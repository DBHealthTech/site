triggers {
    cron('* * * * *')
}

node {
    checkout scm

    // Until JENKINS-41051 is fixed we have to use the docker registry login workaround
    withCredentials([usernamePassword(
        credentialsId: 'docker-creds',
        usernameVariable: 'USERNAME',
        passwordVariable: 'PASSWORD')
    ]) {
        docker.withRegistry('https://docker.nbsoftsolutions.com', 'docker-creds') {
            sh "docker login -u ${USERNAME} -p ${PASSWORD} docker.nbsoftsolutions.com"
            def image = docker.build("nbsoftsolutions/dbhealthtech")
            image.push()
        }

        sshagent(credentials: ['ssh-key']) {
            sh 'ssh -o StrictHostKeyChecking=no -l root 67.205.181.121 "docker pull docker.nbsoftsolutions.com/nbsoftsolutions/dbhealthtech && cd dbhealthtech && docker-compose up -d"'
        }
    }
}
