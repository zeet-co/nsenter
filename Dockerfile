FROM ubuntu

RUN apt-get update -y && \
  apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

RUN apt-get update -y && \
  apt-get install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    net-tools \
    util-linux -y

CMD nsenter -t $(docker inspect -f '{{.State.Pid}}' $DOCKER_CONTAINER_ID) -n netstat -tulpn | tail -n+3
