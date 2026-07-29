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
        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'kubeconfig-cred', variable: 'KUBECONFIG_FILE')]) {
                    sh """
                    export KUBECONFIG=\$KUBECONFIG_FILE
                    sed -i "s/DOCKERHUB_USERNAME/${DOCKERHUB_USERNAME}/g" k8s/*.yaml
                    kubectl apply -f k8s/namespace.yaml
                    kubectl apply -f k8s/secrets.yaml
                    kubectl apply -f k8s/configmap.yaml
                    kubectl apply -f k8s/database-deployment.yaml
                    kubectl apply -f k8s/database-service.yaml
                    kubectl apply -f k8s/backend-deployment.yaml
                    kubectl apply -f k8s/backend-service.yaml
                    kubectl apply -f k8s/frontend-deployment.yaml
                    kubectl apply -f k8s/frontend-service.yaml

                    kubectl rollout restart deployment backend -n myapp
                    kubectl rollout restart deployment frontend -n myapp
                    kubectl rollout restart deployment database -n myapp
                    """  
                }
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