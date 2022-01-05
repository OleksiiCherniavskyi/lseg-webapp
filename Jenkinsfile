def label = "goweb-1.$BUILD_NUMBER-pipeline"
 
podTemplate(label: label, containers: [
 containerTemplate(name: 'kaniko', image: 'gcr.io/kaniko-project/executor:debug', command: '/busybox/cat', ttyEnabled: true)
],
volumes: [
   secretVolume(mountPath: '/root/.docker/', secretName: 'dockercred')
]) {
 node(label) {
   stage('Stage 1: Build with Kaniko') {
     container('kaniko') {
       sh 'docker login; /kaniko/executor --context=git://github.com/OleksiiCherniavskyi/lseg-webapp.git \
               --destination=docker.io/iuad16s1/lseg-webapp:$BUILD_NUMBER \
               --insecure \
               --skip-tls-verify  \
               -v=debug'
     }
   }
 }
}
