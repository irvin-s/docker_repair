FROM contentwisetv/maven-gosu:jdk8  
ARG ANSIBLE_VERSION="2.4.3.0"  
ARG AWSCLI_VERSION="1.14.55"  
RUN apt-get update && apt-get install -y \  
rsync \  
python-pip && \  
rm -rf /var/lib/apt/lists/*  
  
RUN pip install \  
ansible==${ANSIBLE_VERSION} \  
awscli==${AWSCLI_VERSION} \  
boto \  
boto3  
  
RUN mkdir -p /etc/ansible  
RUN echo "localhost" > /etc/ansible/hosts  

