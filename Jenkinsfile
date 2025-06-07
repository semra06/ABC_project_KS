pipeline {
    agent any
    environment {
        IMAGE_NAME = "semra06/my-docker-image"
    }
    stages {
        stage('Code Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/semra06/ABC_project1.git'
            }
        }
        stage('Code Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('Code Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Code Package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Check Directory') {
            steps {
                sh 'pwd'
                sh 'ls -l'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'cp target/ABCtechnologies-1.0.war .'  
                sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."  
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-registry-credentials', url: '']) {
                    sh "docker tag ${IMAGE_NAME}:${env.BUILD_NUMBER} ${IMAGE_NAME}:latest"
                    sh "docker push ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Clean Up Old Containers') {
            steps {
                sh """
                    # Eski konteynerleri durdur ve sil
                    docker ps -q --filter "name=my-tomcat-*" | xargs -r docker stop | xargs -r docker rm
                """
            }
        }
        stage('Deployment') {
            steps {
                sh """
                    # Yeni konteyneri başlat
                    docker run -itd -p 8282:8080 --name my-tomcat-${env.BUILD_NUMBER} semra06/my-docker-image:${env.BUILD_NUMBER}
                """
            }
        }
    }
}
