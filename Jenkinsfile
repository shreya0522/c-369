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
          // Run Packer build and capture the AMI ID from the output file
           sh 'packer build . | tee packer-output.txt' // Output Packer build output to a file
            def packerOutput = readFile('packer-output.txt') // Read the output from the file
            def matcher = (packerOutput =~ /AMIs were created:[^\n]*\n[^\n]*: ([^\n]*)/)
            PACKER_AMI_ID = matcher.find() ? matcher.group(1) : ''
            // Store the matched AMI ID in PACKER_AMI_ID, or set it to an empty string if no match is found
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
