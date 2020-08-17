pipeline {
  environment {
    TF_WORKSPACE = 'dev'
    TF_IN_AUTOMATION = 'true'
    AWS_ACCESS_KEY_ID = credentials("AWS_ACCESS_KEY_ID}")
    AWS_SECRET_ACCESS_KEY = credentials("env.AWS_SECRET_ACCESS_KEY}")
  }
  agent any 
  stages {
    stage('Terraform Init') {
      steps {
        sh "terraform init -input=false"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "terraform plan -out=tfplan -input=false" //-var-file='dev.tfvars'"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "terraform apply -input=false tfplan"
      }
    }
    stage('AWSpec Tests') {
      steps {
          sh '''#!/bin/bash -l
bundle install --path ~/.gem
bundle exec rake spec || true
'''

        junit(allowEmptyResults: true, testResults: '**/testResults/*.xml')
      }
    }
  }
}