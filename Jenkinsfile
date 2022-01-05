#!groovy

pipeline {
  agent none
  stages {
    stage('Docker Build') {
      agent any
      steps {
        sh 'docker build -t iuad16s1/lseg-webapp:latest .'
      }
    }
    stage('Docker Push') {
      agent any
      steps {
        withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'DockerHubPassword', usernameVariable: 'DockerHubUser')]) {
          sh "docker login -u ${env.DockerHubUser} -p ${env.DockerHubPassword}"
          sh 'docker build -t iuad16s1/lseg-webapp:latest'
        }
      }
    }
  }
}
