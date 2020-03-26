# Base image  
FROM ubuntu:latest  
  
# Initial necessary software for next instalations  
RUN apt-get update  
RUN apt-get -y upgrade  
RUN apt-get -y install sudo curl wget build-essential  
  
# Ubuntu user  
USER root  
  
# Install nodejs on container  
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -  
RUN sudo apt-get install -y nodejs  
  
# Install python on container  
RUN sudo apt-get install libssl-dev openssl -y  
RUN wget https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tgz  
RUN sudo tar -xzf Python-3.5.0.tgz  
RUN cd Python-3.5.0 ; ./configure ; make ; sudo make install  
RUN python -V  
RUN rm -rf Python-3.5.0.tgz  
  
# Install pip  
RUN sudo apt-get install python-pip -y  
RUN sudo pip install --upgrade pip  
  
# Create app directory  
WORKDIR /usr/src/app  
  
# Dependencies from node  
#ADD . /src  
COPY package.json .  
  
# Install dependencies from nodejs project  
RUN npm install  
  
# Dependencies from python  
COPY requirements.txt ./  
RUN pip install -r requirements.txt  
  
# Bundle app source  
COPY . .  
  
# Initial bash  
ADD ./start.sh /start.sh  
RUN chmod 755 /start.sh  
  
# Expose ports  
EXPOSE 8889  
EXPOSE 8080  
# Run a bush that starts the python webservice and nodejs server  
CMD ["/bin/bash", "/start.sh"]  

