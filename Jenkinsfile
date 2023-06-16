pipeline {
    agent any
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
                 sh 'docker build -t zombiefish/jtest .'
                }
            }
        }

        stage('Push') {
            steps {
                script{
                 sh 'docker push zombiefish/jtest'
                }
            }
        }
    }
}
