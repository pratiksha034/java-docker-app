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
                // Executes the Maven clean and package command to create the JAR file
                sh 'mvn clean package' 
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                
                // 🛠️ FIX for Windows EOF/BuildKit Error: 
                // We use 'bat' instead of 'docker.build' and add the '--traditional' flag.
                // This ensures Jenkins uses the standard Windows command line.
                bat "docker build --traditional -t \"${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}\" ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    echo "Authenticating and pushing image to Docker Hub..."
                    
                    // We must revert to the 'docker' Groovy command for authentication and push
                    // as it safely handles credentials using the Jenkins secret.
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
