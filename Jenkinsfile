node {
    checkout scm

    docker.withRegistry('https://docker.nbsoftsolutions.com', 'docker-creds') {
        def image = docker.build("nbsoftsolutions/dbhealthtech")
        image.push()
    }
}
