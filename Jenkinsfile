pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"          // change to your AWS region
        TF_WORKDIR = "./"                 // terraform working directory (adjust if needed)
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],   // change branch if needed
                          userRemoteConfigs: [[url: 'https://github.com/yourusername/yourrepo.git']]])
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
                input message: 'Do you want to apply the Terraform plan?'
                dir("${TF_WORKDIR}") {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        success {
            echo "✅ EKS cluster deployed successfully!"
        }
        failure {
            echo "❌ Pipeline failed. Check logs."
        }
    }
}
