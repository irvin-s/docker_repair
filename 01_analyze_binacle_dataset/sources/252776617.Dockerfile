FROM cnadiminti/dynamodb-local:2017-02-16  
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>  
  
# Install python  
RUN apt-get update && apt-get install -y python3 \  
&& rm -rf /var/lib/apt/lists/*  
  
# Install pip  
RUN curl -O https://bootstrap.pypa.io/get-pip.py \  
&& python3 get-pip.py --user  
  
RUN echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc  
  
# Instal aws cli  
RUN /root/.local/bin/pip3 install awscli --upgrade --user  
  
# Copy files to set default configuration  
COPY config ~/.aws/config  
COPY credentials ~/.aws/credentials  

