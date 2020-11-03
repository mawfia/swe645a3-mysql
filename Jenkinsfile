pipeline {
    environment {
      registry = 'mawfia/mysql'
      registryCredential = 'dockerhub-mawfia'
    }
    agent {
        kubernetes {
            yamlFile 'agent.yml'
        }
    }
    stages {
        stage('build') {
            steps {
                  container('docker'){
                  sh 'docker build -t ${registry}:${BUILD_NUMBER} .'
                }
            }
        }
        stage('publish') {
            steps {
                container('docker'){
                    withDockerRegistry([credentialsId: "${registryCredential}", url: ""]) {
                          sh "docker push ${registry}:${BUILD_NUMBER}.0"
                      }
                }
            }
        }
        stage('deploy') {
            steps {
                container('helm'){
                    sh "helm upgrade ${JOB_NAME} --install --force --set version={BUILD_NUMBER} ./mysql"
                }
                echo "MySQL Deployment # ${BUILD_NUMBER} is complete!"
            }
        }
    }
}
