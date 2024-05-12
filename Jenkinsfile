pipeline {
    agent any
    
    environment {
        PACKER_AMI_ID = '' // Initialize PACKER_AMI_ID environment variable
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/shreya0522/c-369.git' 
            }
        }
        
        stage('Run Build Init') {
            steps {
                script {
                    // Run Packer build and capture the AMI ID
                    def packerOutput = sh(script: 'packer build .', returnStdout: true).trim()
                    PACKER_AMI_ID = packerOutput =~ /ami-.+/ ? packerOutput =~ /ami-.+/.toString() : ''
                    // Convert the matched AMI ID to string and store it in PACKER_AMI_ID, or set it to an empty string if no match is found
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
