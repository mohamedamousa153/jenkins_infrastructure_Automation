pipeline {
    agent any

    stages {
        
        
         stage('Read Secret File') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'publicKey', variable: 'SECRET_FILE_PUBLIC')]) {

                        
                        sh 'pwd'
                        sh 'cat $SECRET_FILE_PUBLIC > /var/jenkins_home/workspace/first/terraform/id_rsa.pub'
                        
                      
                    }

                    withCredentials([file(credentialsId: 'privateKey', variable: 'SECRET_FILE_PRIVATE')]) {
                        
                        
                        sh 'cat $SECRET_FILE_PRIVATE > /var/jenkins_home/workspace/first/ansible/id_rsa'

                        
                        
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
                sh 'rm -rf ../ansible/inventory'
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

                
                sh 'sleep 1m'

                sh 'ls'
                
                sh '''
                   host_key_checking = False ansible-playbook playbook.yaml

                '''
            }
            }
        



    }
}

}  
