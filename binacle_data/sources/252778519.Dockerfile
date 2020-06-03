FROM ubuntu:latest  
  
# Install.  
RUN \  
sed -i 's/# \\(.*multiverse$\\)/\1/g' /etc/apt/sources.list && \  
apt-get update && \  
apt-get -y upgrade && \  
apt-get install -y build-essential && \  
apt-get install -y software-properties-common && \  
apt-get install -y byobu curl git htop man unzip vim wget && \  
apt-get install -y golang && \  
rm -rf /var/lib/apt/lists/*  
  
# Add files.  
# ADD root/.bashrc /root/.bashrc  
# ADD root/.gitconfig /root/.gitconfig  
# ADD root/.scripts /root/.scripts # Set environment variables.  
ENV HOME /root  
  
# Define working directory.  
WORKDIR /root  
  
COPY . /var/www  
  
EXPOSE 80  
# Define default command.  
#CMD cd /var/www && \  
# go build main.go && \  
# sleep 2 && \  
# echo 'docker run -it -d -p 80:80 <docker_id> /bin/bash -c "/var/www/main"'  
ENTRYPOINT ["/bin/bash", "-c", "/var/www/main"]  

