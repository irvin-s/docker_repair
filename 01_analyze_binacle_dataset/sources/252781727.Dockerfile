# DESC: Docker file to run AWS CLI and EB CLI tools.  
FROM python:slim  
  
ENV PAGER="more"  
RUN pip install --upgrade \  
pip \  
awsebcli \  
awscli &&\  
mkdir ~/.aws &&\  
echo "complete -C '/usr/local/bin/aws_completer' aws" >> ~/.bashrc && \  
echo "source /usr/local/bin/eb_completion.bash" >> ~/.bashrc  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
git \  
&& rm -rf /var/lib/apt/lists/*  
  
# Expose volume for adding credentials and access local sources  
VOLUME ["~/.aws", "/src"]  
WORKDIR /src

