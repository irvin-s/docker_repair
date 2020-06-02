FROM google/python  
MAINTAINER Ben Rothschild "ben@vroom.com"  
# Make ssh dir  
RUN mkdir /root/.ssh/  
RUN mkdir /root/ben  
  
# Copy over private key, and set permissions  
ADD id_rsa /root/.ssh/id_rsa  
  
RUN apt-get update  
RUN apt-get -yqq install ssh  
RUN apt-get install -y vim python-psycopg2  
  
# Create known_hosts  
RUN touch /root/.ssh/known_hosts  
# Add bitbuckets key  
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts  
  
# Clone the conf files into the docker container  
RUN git clone git@bitbucket.org:bnroths/topgear.git /topgear  
  
ADD creds.json /topgear/creds.json  
WORKDIR /topgear  
  
ADD requirements.txt /topgear/requirements.txt  
RUN pip install -r requirements.txt  
  
ADD creds.json /topgear/creds.json  
# ADD . /app  
#  
# CMD []  
# ENTRYPOINT ["/env/bin/python", "/app/main.py"]#  
# TO DO LUIGI CONFIG FILE

