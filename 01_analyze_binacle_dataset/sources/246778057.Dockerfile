FROM python:2.7

# install some generic Python modules
RUN pip install ansible==2.3
RUN pip install boto==2.46.1
RUN pip install credstash==1.13.2
RUN pip install fasteners==0.14.1
RUN pip install futures==3.0.5
RUN pip install pyfscache==0.9.12
RUN pip install PyYAML==3.12
RUN pip install hvac==0.2.17
RUN pip install awscli==1.11.70
RUN pip install docker==2.5.1

# install docker client
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu trusty stable" && \
    apt-get update && \
    apt-get install -y docker-ce
