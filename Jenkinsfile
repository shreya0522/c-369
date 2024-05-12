pipeline {
    agent any
    
    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository from GitHub
                git branch: 'main', url: 'https://github.com/shreya0522/c-369.git' 
            }
        }
        
        stage('Run Build Init') {
            steps {
                // Change directory to the cloned repository
                dir('c-369') {
                    // Run the build init command
                   // sh 'packer init'
                    sh 'packer build .'
                }
            }
        }
    }
}
