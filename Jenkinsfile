pipeline {
    agent any
    
    environment {
        PACKER_AMI_ID = ''
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
            PACKER_AMI_ID = packerOutput =~ /ami-.+/
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
