pipeline {
    agent {
        docker {
            image 'my-maven-git:latest'
            args '-v C:\Users\user/.m2:/root/.m2'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                sh 'rm -rf *'
                sh 'git clone https://github.com/simoks/java-maven.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    dir('java-maven/maven') {
                        sh 'mvn clean test package'
                        sh 'java -jar target/maven-0.0.1-SNAPSHOT.jar'
                    }
                }
            }
        }
    }
}
