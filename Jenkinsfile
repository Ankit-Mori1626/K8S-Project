pipeline {
    agent any

    environment {
        DOCKERHUB_CREDS = credentials('Docker-hub')
        DOCKERHUB_USERNAME = "${DOCKERHUB_CREDS_USR}"
        BACKEND_URL         = "http://13.234.231.137:30800"
        IMAGE_TAG             = "latest"

    }
    stages {
        stage('checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Ankit-Mori1626/K8S-Project.git'
            }
        }
        stage('Docker Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_USERNAME --password-stdin'
            }
        }
        stage('Build Backend Docker Image') {
            steps {
                sh 'docker build -t $DOCKERHUB_USERNAME/k8s-backend:$IMAGE_TAG ./backend'
            }
        }
        stage('Build Frontend Docker Image') {
            steps {
                sh 'docker build -t $DOCKERHUB_USERNAME/k8s-frontend:$IMAGE_TAG ./frontend'
            }
        }
        stage('Build Database Docker Image') {
            steps {
                sh 'docker build -t $DOCKERHUB_USERNAME/k8s-database:$IMAGE_TAG ./database'
            }
        }
        stage('Push Images to Docker Hub') {
            steps {
                sh 'docker push $DOCKERHUB_USERNAME/k8s-backend:$IMAGE_TAG'
                sh 'docker push $DOCKERHUB_USERNAME/k8s-frontend:$IMAGE_TAG'
                sh 'docker push $DOCKERHUB_USERNAME/k8s-database:$IMAGE_TAG'
            }
        }
    }

    post {
        always {
            sh 'docker logout'
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}