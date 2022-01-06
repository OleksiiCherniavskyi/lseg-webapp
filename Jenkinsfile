#!groovy

def podLabel = "kaniko-${UUID.randomUUID().toString()}"

pipeline {
    agent {
        kubernetes {
            label podLabel
            defaultContainer 'jnlp'
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    jenkins-build: app-build
    some-label: "build-app-${BUILD_NUMBER}"
spec:
  containers:
  - name: helm-operator
    image: iuad16s1/helm-operator:0.3
    imagePullPolicy: IfNotPresent
    command:
    - top
    tty: true
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.5.1-debug
    imagePullPolicy: IfNotPresent
    command:
    - /busybox/cat
    tty: true
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: docker-credentials
          items:
            - key: .dockerconfigjson
              path: config.json
"""
        }
    }

    environment {
        GITHUB_ACCESS_TOKEN = credentials('github-token')
        AWS_DEFAULT_PROFILE = credentials('aws-default-profile')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
    }

  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }
    stage('Build with Kaniko') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          withEnv(['PATH+EXTRA=/busybox']) {
            sh '''#!/busybox/sh -xe
              /kaniko/executor \
                --dockerfile Dockerfile \
                --context `pwd`/ \
                --verbosity debug \
                --insecure \
                --skip-tls-verify \
                --destination iuad16s1/lseg-webapp:$BUILD_NUMBER \
                --destination iuad16s1/lseg-webapp:$BUILD_NUMBER-latest
            '''
          }
        }
      }
    }
    stage('Helm Deploy') {
      steps {
        container(name: 'helm-operator', shell: '/bin/bash' ) {
          sh ''' if [ -d /root/.aws ]; then echo "directory already exist"; else mkdir /root/.aws; fi; \
            echo "[$AWS_DEFAULT_PROFILE]" > /root/.aws/credentials; \
            echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /root/.aws/credentials; \
            echo "aws-secret-access-key = $AWS_SECRET_ACCESS_KEY" >> /root/.aws/credentials; \
            echo "[profile $AWS_DEFAULT_PROFILE]" > /root/.aws/config; \
            echo "region = us-west-2" >> /root/.aws/config; echo "output = json" >> /root/.aws/config; \
            aws eks --region us-west-2 update-kubeconfig --name lseg-eks-T9gWKSdV; \
            export KUBECONFIG=/root/.kube/config; \
            if [[ $BUILD_NUMBER -gt 1 ]]; then helm upgrade lseg-web-app charts/lwa -n default; else helm install lseg-web-app charts/lwa -n default; fi
         '''
        }
      }
    }
  }
}
