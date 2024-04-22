pipeline {
    agent any

    stages {
        
        
         stage('Read Secret File') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'publicKey', variable: 'SECRET_FILE_PUBLIC')]) {
                        
                        sh 'cat $SECRET_FILE_PUBLIC > ./terraform/id_rsa.pub '
                    }

                    withCredentials([file(credentialsId: 'privateKey', variable: 'SECRET_FILE_PRIVATE')]) {
                        
                        sh 'cat $SECRET_FILE_PRIVATE > ./ansible/key/id_rsa '
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
