pipeline {
    agent {
        kubernetes {
            yaml '''
            apiVersion: v1
            kind: Pod
            spec:
              containers:
              # Контейнер для збірки Docker-образів (Kaniko)
              - name: kaniko
                image: gcr.io/kaniko-project/executor:debug
                command:
                - sleep
                args:
                - 9999999
              # Контейнер для роботи з Git та оновлення Helm-чарту
              - name: git
                image: alpine/git
                command:
                - sleep
                args:
                - 9999999
            '''
        }
    }

    environment {
        ECR_REPO = "234164312932.dkr.ecr.eu-central-1.amazonaws.com/lesson-9-ecr"
        AWS_REGION = "eu-central-1"
        IMAGE_TAG = "v1.0.${env.BUILD_NUMBER}"
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout scm
            }
        }

        stage('Build & Push to ECR (Kaniko)') {
            steps {
                container('kaniko') {
                    withCredentials([usernamePassword(credentialsId: 'aws-creds', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                        sh '''
                            /kaniko/executor \
                                --context `pwd` \
                                --dockerfile `pwd`/Dockerfile \
                                --destination ${ECR_REPO}:${IMAGE_TAG}
                        '''
                    }
                }
            }
        }

        stage('Update Helm Chart & Push') {
            steps {
                container('git') {
                    withCredentials([usernamePassword(credentialsId: 'git-creds', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                            git config --global --add safe.directory '*'

                            git config --global user.email "jenkins@devops.local"
                            git config --global user.name "Jenkins CI"

                            sed -i "s/tag: .*/tag: ${IMAGE_TAG}/" charts/django-app/values.yaml

                            git add charts/django-app/values.yaml
                            git commit -m "Update image tag to ${IMAGE_TAG} [skip ci]"

                            REPO_URL=$(git config remote.origin.url | sed "s/https:\\/\\//https:\\/\\/${GIT_USERNAME}:${GIT_PASSWORD}@/")

                            git push $REPO_URL HEAD:lesson-8-9
                        '''
                    }
                }
            }
        }
    }
}