pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        TF_WORKDIR = "./"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/maroayman/terraform-jenkins.git']]])
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${TF_WORKDIR}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir("${TF_WORKDIR}") {
                    sh 'terraform plan -out=tfplan -input=false'
                }
            }
        }

        
        stage('Terraform Apply') {
            steps {
                input message: 'Apply the Terraform plan?'
                dir("${TF_WORKDIR}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
        
/*
        stage('Terraform Destroy') {
            steps {
                input message: 'Destroy the EKS cluster and all resources?'
                dir("${TF_WORKDIR}") {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }
*/
    post {
        success {
            echo "✅ Destroy completed!"
        }
        failure {
            echo "❌ Pipeline failed."
        }
    }
}
