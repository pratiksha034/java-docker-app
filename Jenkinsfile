pipeline {
    agent any
    
    // Define environment variables for Docker Hub authentication and image naming
    environment {
        // REPLACE 'pratikshapawar' and 'java-docker-app' with your details
        DOCKER_IMAGE = "pratikshapawar/java-docker-app" 
        
        // This MUST match the ID of the credential set up in Jenkins
        DOCKER_CREDENTIALS_ID = "docker-hub-credentials-id" 
        
        DOCKER_REGISTRY_URL = "https://registry.hub.docker.com"
    }

    stages {
        stage('Build Java Code') {
            steps {
                echo 'Compiling and packaging the Java application with Maven...'
                // 🛠️ FIX 1: Use 'bat' instead of 'sh' for native Windows execution
                bat 'mvn clean package' 
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                
                // 🛠️ FIX 2: Removed the problematic '--traditional' flag.
                // This uses the standard Windows 'bat' command to run Docker build.
                bat "docker build -t \"${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}\" ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "Authenticating and pushing image to Docker Hub..."
                    
                    // The 'docker.withRegistry' Groovy wrapper must be kept for secure credential handling.
                    docker.withRegistry(env.DOCKER_REGISTRY_URL, env.DOCKER_CREDENTIALS_ID) {
                        def img = docker.image("${env.DOCKER_IMAGE}")
                        
                        // Push with the unique Jenkins build number tag
                        img.push("${env.BUILD_NUMBER}")
                        
                        // Also push with the 'latest' tag
                        img.push('latest')
                    }
                }
            }
        }
    }
    
    post {
        always {
            // Cleans up the workspace after the build is done (optional, but good practice)
            deleteDir() 
        }
    }
}
