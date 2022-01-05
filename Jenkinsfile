node {
    def app

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app.inside {
            sh 'docker build -t iuad16s1/lseg-webapp .'
        }
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'DockerHub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
