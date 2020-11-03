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
                  sh '''
                      if [ -e *.sql ];
                      then
                          export DATA_COPY=copy
                      else
                          export DATA_COPY=no_copy
                      fi
                     '''
                  sh "docker build --build-arg data_copy=${DATA_COPY} -t ${registry}:${BUILD_NUMBER} ."
                }
            }
        }
        stage('publish') {
            steps {
                container('docker'){
                    withDockerRegistry([credentialsId: "${registryCredential}", url: ""]) {
                          sh "docker push ${registry}:${BUILD_NUMBER}"
                      }
                }
            }
        }
        stage('deploy') {
            steps {
                container('helm'){
                    sh "helm upgrade ${JOB_NAME} --install --force --set version=${BUILD_NUMBER} ./mysql"
                }
                echo "MySQL Deployment # ${BUILD_NUMBER} is complete!"
            }
        }
    }
}
