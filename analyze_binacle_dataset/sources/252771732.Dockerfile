FROM debian:jessie  
  
# Set environment variables  
ENV \  
GULP_VERSION=next  
  
ENV \  
GRUNT_VERSION=1.0.2  
ENV \  
WEBPACK_VERSION=4.8.3  
ENV \  
YARN_VERSION=1.7.0  
# Run updates  
RUN \  
echo -e "\nRunning apt-get update..." && \  
apt-get update  
  
# Install curl  
RUN \  
echo -e "\nInstalling curl..." && \  
apt-get install -y curl  
  
# Install Node 8  
RUN \  
echo -e "\nInstalling Node 8..." && \  
curl -sL https://deb.nodesource.com/setup_8.x | bash - && \  
apt-get install -y nodejs  
  
# Install wget  
RUN \  
echo -e "\nInstalling wget..." && \  
apt-get install -y wget  
  
# Install openssl  
RUN \  
echo -e "\nInstalling openssl..." && \  
apt-get install -y openssl  
  
# Install git  
RUN \  
echo -e "\nInstalling git..." && \  
apt-get install -y git  
  
# Install ssh  
RUN \  
echo -e "\nInstalling ssh..." && \  
apt-get install -y ssh  
  
# Install rsync  
RUN \  
echo -e "\nInstalling rsync..." && \  
apt-get install -y rsync  
  
# Install gulp globally  
RUN \  
echo -e "\nInstalling gulp v${GULP_VERSION}..." && \  
npm install -g gulp@${GULP_VERSION}  
  
# Install grunt globally  
RUN \  
echo -e "\nInstalling grunt v${GRUNT_VERSION}..." && \  
npm install -g grunt@${GRUNT_VERSION}  
  
# Install webpack globally  
RUN \  
echo -e "\nInstalling webpack v${WEBPACK_VERSION}..." && \  
npm install -g webpack@${WEBPACK_VERSION}  
  
# Install yarn globally  
RUN \  
echo "Installing yarn v${YARN_VERSION}..." && \  
npm install -g yarn@${YARN_VERSION}  

