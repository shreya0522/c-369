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
        
        stage('Create Launch Template Version') {
            steps {
                  script {
            // Define a file to capture command output
            def outputFileName = "create-launch-template-version-output.txt"

            // Run the command to create launch template version and capture the output
            sh """
                aws ec2 create-launch-template-version \
                    --launch-template-name C360-TEMPLATE \
                    --source-version 1 \
                    --version-description 'Version 3 with updated AMI' \
                    --launch-template-data '{ "ImageId": "ami-0b702bb0136516fb6", "InstanceType": "t2.micro", "SecurityGroupIds": ["sg-0b7f7d077bfefa5fd"] }' \
                    > ${outputFileName} 2>&1
            """

            // Read the output file
            def createVersionOutput = readFile(outputFileName).trim()

            // Print the output for debugging
            echo "Create Launch Template Version Output: ${createVersionOutput}"

            // Check if there was any error or warning in the output
            if (createVersionOutput.contains("error") || createVersionOutput.contains("warning")) {
                error "Error or warning occurred during launch template version creation:\n ${createVersionOutput}"
            }

            // Extract the version number from the output
            def versionMatcher = (createVersionOutput =~ /"VersionNumber"\s*:\s*(\d+)/)
            LAUNCH_TEMPLATE_VERSION = versionMatcher.find() ? versionMatcher.group(1) : ''

            // Echo the created version number
            echo "Created launch template version: ${LAUNCH_TEMPLATE_VERSION}"
                 }
            }
        }
        
        // stage('Modify Launch Template') {
        //     steps {
        //         script {
        //             sh 'aws ec2 modify-launch-template --launch-template-name C360-TEMPLATE --default-version 3'
        //         }
        //     }
        // }
        
        // stage('Update Auto Scaling Group') {
        //     steps {
        //         script {
        //             sh 'aws autoscaling update-auto-scaling-group --auto-scaling-group-name c360-asg --launch-template "LaunchTemplateName=C360-TEMPLATE,Version=3"'
        //         }
        //     }
        // }
        
        // stage('Start Instance Refresh') {
        //     steps {
        //         script {
        //             sh 'aws autoscaling start-instance-refresh --auto-scaling-group-name c360-asg --preferences \'{"InstanceWarmup": 60, "MinHealthyPercentage": 50}\''
        //         }
        //     }
        // }
    }
}
