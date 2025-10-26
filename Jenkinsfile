pipeline {
    agent any
    
    // Define environment variables for Docker Hub authentication and image naming
    environment {
        // 🛠️ FINAL FIX: Disable BuildKit to resolve EOF error on Windows
        DOCKER_BUILDKIT = '0' 
        
        // Your existing variables:
        DOCKER_IMAGE = "pratikshapawar/java-docker-app" 
        DOCKER_CREDENTIALS_ID = "docker-hub-credentials-id" 
        DOCKER_REGISTRY_URL = "https://registry.hub.docker.com"
    }

    stages {
        stage('Build Java Code') {
            steps {
                echo 'Compiling and packaging the Java application with Maven...'
                bat 'mvn clean package' // Already correctly set to 'bat'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}"
                
                // This command is now correct and will respect DOCKER_BUILDKIT=0
                bat "docker build -t \"${env.DOCKER_IMAGE}:${env.BUILD_NUMBER}\" ."
            }
        }
        // ... (Push Docker Image stage remains the same)
        stage('Push Docker Image') {
            steps {
                script {
                    echo "Authenticating and pushing image to Docker Hub..."
                    docker.withRegistry(env.DOCKER_REGISTRY_URL, env.DOCKER_CREDENTIALS_ID) {
                        def img = docker.image("${env.DOCKER_IMAGE}")
                        img.push("${env.BUILD_NUMBER}")
                        img.push('latest')
                    }
                }
            }
        }
    }
    
    post {
        always {
            deleteDir() 
        }
    }
}
