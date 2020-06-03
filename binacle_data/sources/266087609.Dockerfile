###############################################################################################
# Purpose:  Provide a Flask+nginx+uwsgi container on Ubuntu 16.04 via ports 80 and 443
#
# Forked from Thatcher Peskens <thatcher@dotcloud.com>
#    github - https://github.com/atupal/dockerfile.flask-uwsgi-nginx
#
# Build:
# sudo docker build -t flaskwebpage .
#
# Run HTTP:
# sudo docker run -d -p 80:80 --restart=always -t --name flaskwebpage flaskwebpage
#
# Setup HTTPS Automatically with domain name (-d), cert name (-n) and email (-e).  DOMAIN ONLY:
# sudo docker run -d -p 80:80 -p 443:443 --restart=always -t --name flaskwebpage flaskwebpage "-d example.com,www.example.com -n example.com -e my@email.com"
#
# Run for HTTPS but set up HTTPS certs later:
# sudo docker run -d -p 80:80 -p 443:443 --restart=always -t --name flaskwebpage flaskwebpage
#
#    Setup HTTPS after starting the container as HTTP:
#        - Run: /home/flask/conf/setup-https.py -d [domain_list_csv] -n [certname] -e [email_address]
###############################################################################################

from ubuntu:16.04

# Add all local code to the docker container and 
add . /home/flask/

#Change the HTTPS config scripts to executable
run chmod +x /home/flask/conf/setup-https.py

#Add latest nginx repo and install base programs
run apt-get update
run apt-get install -y software-properties-common
run add-apt-repository -y ppa:nginx/stable
run apt-get install -y build-essential nano nginx net-tools python3 python3-dev python3-setuptools python3-software-properties python3-pip supervisor wget
run pip3 install --upgrade pip

# Install uwsgi and flask via the requirements.txt file
run pip3 install -r /home/flask/conf/requirements.txt


#Update all the things
run apt-get update && apt-get -y upgrade

# Config all the things, inititally for HTTP, not HTTPS
run rm /etc/nginx/sites-enabled/default
run ln -s /home/flask/conf/nginx-http.conf /etc/nginx/sites-enabled/
run ln -s /home/flask/conf/supervisor.conf /etc/supervisor/conf.d/

#Get Letsencrypt certbot so you can have it if you want HTTPS
run wget -O /home/flask/conf/certbot-auto https://dl.eff.org/certbot-auto
run chmod a+x /home/flask/conf/certbot-auto

# Expose both ports in case you want to start using HTTPS
expose 80 443
ENTRYPOINT ["/home/flask/start.sh"]
