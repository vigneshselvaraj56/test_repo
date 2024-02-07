pipeline {
    agent any
    
    environment {
      USER_CREDENTIALS = credentials('git_creds')
      REMOTE_HOST = '43.204.148.182'
      REMOTE_USER = 'testuser'
      PATH = '~/'
      CRONTAB_PATH = '/usr/bin/crontab'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scmGit(branches: [[name: 'main']], extensions: [], userRemoteConfigs: [[credentialsId: 'git_creds', url: 'https://github.com/vigneshselvaraj56/test_repo.git']])
            }
        }
        stage ('Get Changed Files'){
            steps {
                script{
                    
                    def changedFiles = sh(script: "git diff --name-only HEAD^ -- ':!Jenkinsfile' ':!script.sh'",returnStdout: true).trim().split('\n')
                    env.Changed_Files = changedFiles.join(' ')
                    echo env.Changed_Files
                    }
            }
        }
        stage ('Copy the changed files to server') {
            steps {
               script {

                sshagent(credentials: ['remote-server-new']){

                  env.Changed_Files.split().each{file -> def directory = sh(script: "dirname ${file}",returnStdout: true).trim()
                  sh """
                  ssh -o StrictHostKeyChecking=no ${REMOTE_USER}@${REMOTE_HOST} "mkdir -p ${PATH}/${directory}"
                  scp -o StrictHostKeyChecking=no "${WORKSPACE}"/${file} ${REMOTE_USER}@${REMOTE_HOST}:${PATH}/${file}
                  """
                  }
             
                }
            }
        }    
    }
  }
}

