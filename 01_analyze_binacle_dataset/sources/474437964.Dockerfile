# Get base image
FROM ubuntu:15.04

# Install the required packages
RUN apt-get update && apt-get -y install python-pip rabbitmq-server git wget clamav && pip install Flask && pip install elasticsearch && pip install pika && pip install -U flask-cors

# Install docker
RUN wget -qO- https://get.docker.com/ | sh

# Package the code
RUN git clone https://github.com/BU-NU-CLOUD-SP16/Container-Code-Classification /usr/local/ccs

WORKDIR /usr/local/ccs/scripts

# Install sdhash
RUN /usr/local/ccs/scripts/install_sdhash.sh

# Update the code and clamav database
RUN git pull && freshclam

CMD ["/bin/bash", "start_services.sh"]
