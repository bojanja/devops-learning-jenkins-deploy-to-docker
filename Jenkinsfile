pipeline {
    agent any 
    environment {
        //once you sign up for Docker hub, use that user_id here
        registry = "bojanja/devops-learning-jenkins-deploy-to-docker"
        //- update your credentials ID after creating credentials for connecting to Docker Hub
        registryCredential = '0eaa1358-2ecd-4e9e-b5b7-78cf8c9bf20b'
        dockerImage = ''
    }
    
    stages {
    stage('Cloning Git') {
            steps {
                git credentialsId: '82455f0c-a33f-4ce5-a183-e16b0481264d', url: 'https://github.com/bojanja/devops-learning-jenkins-deploy-to-docker.git'
            }
        }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
    
     // Uploading Docker images into Docker Hub
    stage('Upload Image') {
     steps{    
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            }
        }
      }
    }
    
    // Stopping Docker containers for cleaner Docker run
    stage('docker stop container') {
         steps {
            sh 'docker ps -f name=devops-learning-jenkins-deploy-to-dockerContainer -q | xargs --no-run-if-empty docker container stop'
            sh 'docker container ls -a -fname=ddevops-learning-jenkins-deploy-to-dockerContainer -q | xargs -r docker container rm'
         }
       }
    
    
    // Running Docker container, make sure port 8096 is opened in 
    stage('Docker Run') {
     steps{
         script {
            dockerImage.run("-p 8096:80 --rm --name devops-learning-jenkins-deploy-to-dockerContainer")
         }
      }
    }
  }
}