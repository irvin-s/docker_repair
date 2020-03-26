FROM ubuntu
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get -y update

# Install some essentials
RUN apt-get -y update
RUN apt-get install -y wget curl sudo

# Add elasticsearch apt repository
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Install other required packages
RUN apt-get -y update
RUN apt-get install -y elasticsearch git openjdk-9-jre openssh-server postgresql-9.5 postgresql-server-dev-9.5 python3 python3-pip supervisor nginx vim

# Set up postgres
USER postgres
RUN service postgresql start && createuser jazzchords && createdb -O jazzchords jazzchords

# Add configurations
ADD supervisor/ /etc/supervisor/
ADD uwsgi/ /etc/uwsgi/
ADD nginx/ /etc/nginx/

# Add jazzchords user
USER root
RUN useradd jazzchords -ms /bin/bash
RUN usermod -a -G sudo jazzchords
RUN echo "jazzchords:jazzchords" | chpasswd

# Create /srv/jazzchords/ dir
USER root
RUN mkdir /srv/jazzchords/
RUN chown jazzchords:jazzchords /srv/jazzchords/

# Get the code and make it ready
USER jazzchords
WORKDIR /srv/jazzchords/
RUN git clone https://github.com/gitaarik/jazzchords.git .
RUN echo "ENVIRONMENT = 'production'" > settings/environment.py

# Parse static files
USER jazzchords
WORKDIR /srv/jazzchords/dev/
RUN npm install
RUN node_modules/.bin/gulp parsestatic

# Install pip requirements
USER root
RUN pip3 install --upgrade pip
RUN pip3 install -r pip_requirements.txt
RUN pip3 install -r pip_requirements_production.txt

# Migrate
WORKDIR /srv/jazzchords/
RUN service postgresql start && su jazzchords -c "./manage.py migrate"
# && su jazzchords -c "./manage.py loaddata dev/data-dump.json"

# Open ports for ssh, http and https
EXPOSE 22 80 443

# Configure locals
RUN locale-gen "en_US.UTF-8"
RUN dpkg-reconfigure locales

# Start ssh, elasticsearch and supervisor
ENTRYPOINT service ssh start && service nginx start && service postgresql start && service elasticsearch start && /usr/bin/supervisord
