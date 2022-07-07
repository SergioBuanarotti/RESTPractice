pipeline {
    agent any
    environment {
      PROJECT_NAME = "Neptun"
      OWNER_NAME   = "SergioBuanarotti"
    }

    stages {
        stage('1-Build') {
            steps {
                echo "Start Building dependencies..."
                shell python3 -m virtualenv venv
                source venv/bin/activate
                pip3 install -r requirements.txt
                
            }
        }
        stage('2-Test') {
            steps {
                shell robot -d results tests
                echo "End of Stage Build..."
            }
        }
        stage('3-Deploy') {
            steps {
                echo "Start of Stage Deploy..."
                echo "Deploying......."
                sh "ls -la"
                sh '''
                   echo "Line1"
                   echo "Line2"
                '''
                echo "End of Stage Build..."
            }
        }
        stage('4-Celebrate') {
            steps {
                echo "CONGRATULYACIYA!"
            }
        }	
    }
}
