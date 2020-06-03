FROM ansible/ansible-runner:latest

RUN pip install --upgrade pip \
    && pip install 'cryptography>=2.2.1' 'boto' 'boto3' 'apache-libcloud' 'ansible[azure]' 

VOLUME /runner/env
