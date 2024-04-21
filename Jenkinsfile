pipeline {
    agent any

    stages {
        
        
         stage('Read Secret File') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'publicKey', variable: 'SECRET_FILE')]) {
                        
                        sh 'cat $SECRET_FILE > ./terraform/public.pem '
                    }

                    withCredentials([file(credentialsId: 'privateKey', variable: 'SECRET_FILE2')]) {
                        
                        sh 'cat $SECRET_FILE2 > ./ansible/private.pem '
                    }


                }
            }
         }



        stage('Terraform') {


            
                        
                        
                    


            steps {

                script {
                     withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'awskey']]) {
                        
                dir('terraform'){

                sh 'ls'
                sh 'terraform init'
                

                
                // Generate Terraform plan
                sh 'terraform plan'
                

                

                sh 'terraform apply -auto-approve'
                }
                    }
                }


            }

          

        }

        


        stage('Run Ansible Playbook') {
            steps {

                
                // Execute the ansible-playbook command
                dir('ansible'){


                sh 'ls'
                
                sh '''
                    ansible-playbook -i inventory playbook.yaml
                '''
            }
            }
        



    }
}

}  
