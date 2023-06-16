env.DOCKER_HOST = 'tcp://ap-docker.highvail.com:2375'

pipeline {
    agent docker
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') {
            steps {
                script{
                checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script{
                 app = docker.build("underwater")
                }
            }
        }
        stage('Test'){
            steps {
                 echo 'Empty'
            }
        }
    }
}
