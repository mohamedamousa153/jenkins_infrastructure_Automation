pipeline {
    agent any

    stages {
        
        
        //  stage('Read Secret File') {
        //     steps {
        //         script {
        //             withCredentials([file(credentialsId: 'publicKey', variable: 'SECRET_FILE_PUBLIC')]) {

                        
        //                 sh 'pwd'
        //                 sh 'cat $SECRET_FILE_PUBLIC > /var/jenkins_home/workspace/first/terraform/id_rsa.pub'
                        
                      
        //             }

        //             withCredentials([file(credentialsId: 'jenkinstest_prirvate', variable: 'SECRET_FILE_PRIVATE')]) {
                        
                        
        //                 sh 'cat $SECRET_FILE_PRIVATE > /var/jenkins_home/workspace/first/ansible/jenkinstest.pem'

                        
                        
        //             }


        //         }
        //     }
        //  }



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

                
                sleep time: 60, unit:'SECONDS'
                echo 'woke up after'

                sh 'ls'
                sh 'ansible-playbook -i inventory --private-key=../.ssh/jenkinstest.pem -u ubuntu ./ansible/playbook.yaml'
                
                // sh '''
                //    host_key_checking = False ansible-playbook playbook.yaml

                // '''
            }
            }
        



    }
}

}  
