pipeline {
    agent any

    stages {

        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                // Generate Terraform plan
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            
            steps {
                // Apply Terraform changes
                dir('terraform'){
                sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {

                
                // Execute the ansible-playbook command
                dir('ansbile'){

                
                sh '''
                    ansible-playbook -i inventory playbook.yaml
                '''
            }
            }
        



    }
    }
}