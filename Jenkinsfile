pipeline {
  environment {
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID")
    AWS_SECRET_ACCESS_KEY = credentials("AWS_SECRET_ACCESS_KEY")
  }
  agent any 
  stages {
    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false"
      }
    }
    stage('Terraform Prod Workspace') {
       when{
         branch 'master'
       }
       steps {
        sh "terraform workspace new prod || : && terraform workspace select prod"
      }
    }
    stage('Terraform Dev Workspace') {
       when{
         branch 'develop'
       }
       steps {
        sh "terraform workspace new dev || : && terraform workspace select dev"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan-to-apply -input=false"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "terraform apply -input=false tfplan-to-apply"
      }
    }
    stage('Run Cloud Custodian to govern the resources') {
      steps {
        sh "custodian run -s out ./resources.yaml -r us-east-2"
      }
    }
  }
}