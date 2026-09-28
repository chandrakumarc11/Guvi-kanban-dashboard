pipeline {
    agent any

    environment {
        IMAGE_NAME = "chandru04/kanban-dashboard"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Source') {
            steps {
                git branch: 'main',
                url: 'https://github.com/chandrakumarc11/Guvi-kanban-dashboard.git'
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME:$IMAGE_TAG .
                docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
                '''
            }
        }

        stage('Docker Hub Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds',
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {
            steps {
                sh '''
                docker push $IMAGE_NAME:$IMAGE_TAG
                docker push $IMAGE_NAME:latest
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                docker stop kanban-app || true
                docker rm kanban-app || true

                docker run -d \
                --name kanban-app \
                --restart unless-stopped \
                --memory=512m \
                --cpus=1 \
                -p 3000:80 \
                $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                sleep 20

                curl -f http://localhost:3000
                '''
            }
        }
    }

    post {

        success {
            echo 'Deployment Successful'
        }

        failure {
            echo 'Deployment Failed'

            sh '''
            docker logs kanban-app || true
            '''
        }
    }
}
