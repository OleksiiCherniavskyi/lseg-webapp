#!groovy

pipeline {
  agent kubernetes 
    stages {
      stage('Build') {
        steps {
          container('docker') {
            sh 'docker build -t iuad16s1/lseg-webapp:$BUILD_NUMBER .'
          }
        }
      }
      stage('Push') {
        steps {
          container('docker') {
            sh """
               docker push iuad16s1/lseg-webapp:$BUILD_NUMBER .
            """
          }
        }
      }
    }
}
