pipeline{
    agent{
        dockerfile{
            Dockerfile
            label 'api-test'
            additionalBuildArgs  '--build-arg version=1.0.2'
        }
    }
    stages{
        stage('Build API Image'){
            steps{
                sh 'docker build -t zombiefisf/jtest .'
            }
        }
    }
}
