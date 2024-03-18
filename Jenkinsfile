pipeline {
   environment {
        registry = "attusale21/surveyform645"
        registryCredential = 'dockercred'
        TIMESTAMP = new Date().format("yyyyMMdd_HHmmss")
    }
   agent any

   stages {
      stage('Build') {
         steps {
            script{
               sh 'rm -rf *.war'
               sh 'jar -cvf SurveyForm.war -C .'
               //sh 'echo ${BUILD_TIMESTAMP}'
               docker.withRegistry('',registryCredential){
                  def customImage = docker.build("attusale21/surveyform645:${env.TIMESTAMP}")
               }
            }
         }
      }

      stage('Push Image to Dockerhub') {
         steps {
            script{
               docker.withRegistry('',registryCredential){
                  sh "docker push attusale21/surveyform645:${env.TIMESTAMP}"
               }
            }
         }
      }

      stage('Deploying to Rancher to single node(deployed in 3 replicas)') {
         steps {
            script{
               sh "kubectl set image deployment/deploymentone container-0=attusale21/surveyform645:${env.TIMESTAMP}"
            }
         }
      }

      stage('Deploying to Rancher using Load Balancer as a service') {
         steps {
            script{
               sh "kubectl set image deployment/deploymentone-lb container-0=attusale21/surveyform645:${env.TIMESTAMP}"
            }
         }
      }
   }
}
