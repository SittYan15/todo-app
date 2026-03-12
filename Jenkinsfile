// pipeline {
//     agent {
//         docker {
//             // image 'node:lts-buster-slim'
//             image 'mrts/docker-python-nodejs-google-chrome'            
//             args '-p 3000:3000'
//         }
//     }

//     environment {
//         CI = 'true'
//     }

//     stages {
//         stage('Build') {
//             steps {
//                 sh 'npm install'
//             }
//         }
//         stage('Test') {
//             steps {
//                 // start the server
//                 sh 'npm run test'
//             }
//         }
//         stage('Deploy') {
//             steps {
//                 echo 'Deploying....'
//             }
//         }
//     }
// }


pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'sittyan'
        IMAGE_NAME = 'todo-app'
        DOCKER_HUB_CREDS = 'docker-hub-credentials'
    }

    stages {

        stage('Build') {
            steps {
                script {
                    def dockerTool = tool 'docker' // Matches the name in Global Tool Configuration
                    withEnv(["PATH+DOCKER=${dockerTool}/bin"]) {
                        sh 'docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest .'
                    }
                }
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKER_HUB_CREDS}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {

                    sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
                    sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                }
            }
        }
    }
}
