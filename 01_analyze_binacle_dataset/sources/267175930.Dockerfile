FROM solita/ubuntu-systemd
ADD install-minikube.sh /
ADD install-docker.sh /
RUN apt-get update -y && \
    apt-get install -y wget sudo curl && \
    cd bin/ && \
    curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    cd .. && \
    sh install-docker.sh && \
    sh install-minikube.sh 
RUN minikube start --vm-driver=none
