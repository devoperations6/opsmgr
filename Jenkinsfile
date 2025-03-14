pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'devoperatio6/myapp1'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from GitHub
                git 'https://github.com/devoperations6/opsmgr.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh 'docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Optionally run tests (e.g., unit tests, Flask app test, etc.)
                    // For Flask app, you can run 'pytest' or any testing framework
                    sh 'docker run --rm ${DOCKER_IMAGE}:${BUILD_NUMBER} python -m unittest discover'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Log in to Docker Hub (Make sure your Jenkins has Docker Hub credentials stored)
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    }
                    // Push the image to Docker Hub
                    sh 'docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}'
                }
            }
        }

        stage('Deploy to Server (optional)') {
            steps {
                script {
                    // SSH into the server and deploy the Docker container
                    // Assuming you have a Docker host that can run the containers
                    sh '''
                    ssh -o StrictHostKeyChecking=no jenkins@192.168.0.169 "docker pull ${DOCKER_IMAGE}:${BUILD_NUMBER} && docker run -d -p 5000:5000 ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    '''
                }
            }
        }
    }
}
