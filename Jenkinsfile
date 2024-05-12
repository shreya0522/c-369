pipeline {
    agent any
    
    
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/shreya0522/c-369.git' 
            }
        }
        
        stage('Run Build Init') {
            steps {
                dir('c-369') {
                    sh 'packer init'
                    // Run Packer build and capture the AMI ID
                    script {
                        PACKER_AMI_ID = sh(script: 'packer build . | grep "ami-" | cut -d \':\' -f2', returnStdout: true).trim()
                    }
                }
            }
        }
        
        stage('Use AMI') {
            steps {
                // Access the AMI ID from the environment variable and use it
                script {
                    echo "AMI ID: ${PACKER_AMI_ID}"
                    // Use the AMI ID in your next steps...
                }
            }
        }
    }
}
