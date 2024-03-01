//This file with create a CI/CD pipeline for building and deploying the docker image to k8 cluster using Github as source control version.

@Library('docker') _
pipeline {
    agent any
    environment {
        registry = "attusale21/surveyform645"
        registryCredential = 'dockercred'
        dateTag = new Date().format("yyyyMMdd-HHmmss")
    }
    stages {
        stage('Building war') {
            steps {
                script {
                    sh 'rm -rf *.war'
                    sh 'jar -cvf SurveyForm.war .'
                }
            }
        }
        stage('Building Docker image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        def img = docker.build("attusale21/surveyform645:$dateTag")
                    }
                }
            }
        }
        stage('Pushing Docker image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        def image = docker.image("attusale21/surveyform645:$dateTag")
                        image.push()
                    }
                }
            }
        }
        stage('Deploying to single node in Rancher') {
            steps {
                script {
                    sh "kubectl set image deployment/surveyform container-0=attusale21/surveyform645:$dateTag"
                    sh "kubectl set image deployment/surveyformlb container-0=attusale21/surveyform645:$dateTag"
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
