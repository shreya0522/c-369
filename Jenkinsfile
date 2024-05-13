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
            def matcher = (packerOutput =~ /ami-.+/)
            PACKER_AMI_ID = matcher.find() ? matcher.group().replaceAll(/[^a-zA-Z0-9-]/, '') : ''
            // Clean up the AMI ID and store it in PACKER_AMI_ID, or set it to an empty string if no match is found
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
        
        stage('Create Launch Template Version') {
            steps {
                script {
                    sh """
                aws ec2 create-launch-template-version \
                    --launch-template-name C360-TEMPLATE \
                    --source-version 1 \
                    --version-description 'Version 3 with updated AMI' \
                    --launch-template-data '{ "ImageId": "${PACKER_AMI_ID}", "InstanceType": "t2.micro", "SecurityGroupIds": ["sg-0b7f7d077bfefa5fd"] }'
            """
                }
            }
        }
        
        stage('Modify Launch Template') {
            steps {
                script {
                    sh 'aws ec2 modify-launch-template --launch-template-name C360-TEMPLATE --default-version 3'
                }
            }
        }
        
        stage('Update Auto Scaling Group') {
            steps {
                script {
                    sh 'aws autoscaling update-auto-scaling-group --auto-scaling-group-name c360-asg --launch-template "LaunchTemplateName=C360-TEMPLATE,Version=3"'
                }
            }
        }
        
        stage('Start Instance Refresh') {
            steps {
                script {
                    sh 'aws autoscaling start-instance-refresh --auto-scaling-group-name c360-asg --preferences \'{"InstanceWarmup": 60, "MinHealthyPercentage": 50}\''
                }
            }
        }
    }
}
