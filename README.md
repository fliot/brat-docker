# :hatching_chick: brat docker

This is a docker container deploying an instance of [brat](http://brat.nlplab.org/).
Initially from [cassj](https://github.com/cassj/brat-docker)
Forked by [babylonhealth](https://github.com/babylonhealth/brat-docker)
And re-forked by [me](https://github.com/fliot/brat-docker)

# :warning: brat version
Warning, the brat packed/installed version is a realtime *git clone https://github.com/nlplab/brat.git master/HEAD*

### Build and Installation

Use the build command to create a docker image locally.
```bash
docker build -t brat-docker .
```

now, dive into the image filesystem(s), install your collections (example from http://www.nactem.ac.uk/phenotype/download.php), and define users & passwords:
```bash
docker run --name=brat-docker -it -v $PWD/brat-data:/bratdata -v $PWD/brat-cfg:/bratcfg brat-docker /bin/bash

cd /bratdata
wget http://www.nactem.ac.uk/phenotype/PhenoCHF-corpus.tar.gz
tar -zxvf PhenoCHF-corpus.tar.gz

cd /bratcfg
echo """{
    "user1": "password",
    "user2": "password"
}""" > users.json
exit

docker rm brat-docker
```

### Running

To run the container you need to specify a username, password and email address for BRAT as environment variables when you start the container. This user will have editor permissions.
```bash
docker run --name=brat -d --name brat-docker -p 8888:80 -v $PWD/brat-data:/bratdata -v $PWD/brat-cfg:/bratcfg -e BRAT_USERNAME=brat -e BRAT_PASSWORD=brat -e BRAT_EMAIL=brat@example.com brat-docker

docker logs -f brat-docker
docker container stop brat-docker
docker container rm brat-docker
```
