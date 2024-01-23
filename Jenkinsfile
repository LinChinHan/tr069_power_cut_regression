pipeline {
  agent any
  stages {
    stage('test') {
      parallel {
        stage('test') {
          steps {
            sh '''echo "Hello pipeline"
'''
          }
        }

        stage('test2') {
          steps {
            sh 'echo "Hello pipeline 2"'
          }
        }

      }
    }

    stage('check') {
      steps {
        echo 'finished!!!!!!!!!'
      }
    }

    stage('check 2') {
      steps {
        echo 'testcheck 2'
      }
    }

    stage('aaaaa') {
      steps {
        sleep 5
      }
    }

  }
}