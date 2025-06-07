pipeline {
    agent any
    environment {
        IMAGE_NAME = "semra06/my-docker-image"
    }

    stages {
        stage('code checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/semra06/ABC_project1.git'
            }
        }

        stage('code compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('code test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('code build') {
            steps {
                sh 'mvn package'
            }
        }

        stage('docker image build') {
            steps {
                sh 'cp target/ABCtechnologies-1.0.war .'
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            }
        }

        stage('docker image push') {
            steps {
                withDockerRegistry([credentialsId:'docker-registry-credentials', url:""]) {
                    sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
        }

        stage('application deployment') {
            steps {
                sh """
                    export IMAGE_NAME=${IMAGE_NAME}
                    export BUILD_NUMBER=${BUILD_NUMBER}
                    envsubst < abcdeploy.yaml | kubectl apply -f -
                """
                sh "kubectl apply -f abcservice.yaml"
            }
        }
    }
}
