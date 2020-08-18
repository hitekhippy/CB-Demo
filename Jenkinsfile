pipeline {
  environment {
    TF_WORKSPACE_ENV = 'default'
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
    stage('Terraform Workspace') {
      when{
        branch 'master'
      }
      steps {
        sh "terraform workspace new prod || true && terraform workspace select prod"
      }
       when{
        branch 'develop'
      }
      steps {
        sh "terraform workspace new dev || true && terraform workspace select dev"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan-to-apply -input=false" //-var-file='dev.tfvars'"
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