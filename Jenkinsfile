pipeline {

  agent any

  environment {
    DOCKERHUB_CREDENTIALS=credentials('Fatimah-K-dockerhub-token')
    AWS_ACCESS_KEY_ID     = credentials('Fatimah-K-aws-secret-key-id')
    AWS_SECRET_ACCESS_KEY = credentials('Fatimah-K-aws-secret-access-key')
    ARTIFACT_NAME = 'Dockerrun.aws.json'
    AWS_S3_BUCKET = 'fatimah-k-belt2d4-artifacts-123456'
    AWS_EB_APP_NAME = 'RUNaWAY'
    AWS_EB_ENVIRONMENT_NAME = 'Runaway-env'
    AWS_EB_APP_VERSION = "${BUILD_ID}"
    
  }

  stages {

        stage('Build') {

      steps {
        sh 'docker build -t  fatimahk27/runaway:1.0 .'
      }
    }

        stage('Login') {

      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }

    stage('Push') {

      steps {
        sh 'docker push fatimahk27/runaway:1.0'
      }
    }

        stage('Deploy') {
            steps {
                sh 'aws configure set region us-east-1'
                sh 'aws elasticbeanstalk create-application-version --application-name $AWS_EB_APP_NAME --version-label $AWS_EB_APP_VERSION --source-bundle S3Bucket=$AWS_S3_BUCKET,S3Key=$ARTIFACT_NAME'
                sh 'aws elasticbeanstalk update-environment --application-name $AWS_EB_APP_NAME --environment-name $AWS_EB_ENVIRONMENT_NAME --version-label $AWS_EB_APP_VERSION'
            }
  }
    }
  post {
    always {
      sh 'docker logout'
    }
  }

}