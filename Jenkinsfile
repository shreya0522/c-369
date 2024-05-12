pipeline {
    agent any
    
    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository from GitHub
                git 'https://github.com/your-username/your-repo.git'
            }
        }
        
        stage('Run Build Init') {
            steps {
                // Change directory to the cloned repository
                dir('your-repo-directory') {
                    // Run the build init command
                    sh 'build init'
                }
            }
        }
    }
}
