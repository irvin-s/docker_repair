FROM ubuntu  
MAINTAINER Carl Su <bcbcarl@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install curl, git and nodejs  
RUN \  
apt-get update -q && \  
apt-get install -y curl git nodejs-legacy npm && \  
apt-get clean && rm -rf /var/lib/apt/lists/*  
  
# Install Meteor  
RUN curl https://install.meteor.com/ | sh  
  
# Install Meteorite  
RUN npm install -g meteorite  
  
# Download metrello  
RUN git clone https://github.com/yasaricli/metrello  
  
# Initialize  
WORKDIR metrello  
EXPOSE 3000  
CMD ["mrt"]  

