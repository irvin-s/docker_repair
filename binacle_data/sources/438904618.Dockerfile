# VERSION               0.0.2
# DOCKER-VERSION        0.3.2
#
# TODO: work in progress
#
from    base:ubuntu-12.10
maintainer  Thomas Frössman <thomasf@josysstem.se>
run echo 'deb http://archive.ubuntu.com/ubuntu quantal main universe multiverse' > /etc/apt/sources.list
run DEBIAN_FRONTEND=noninteractive apt-get update
# Things required for a python/pip environment
run DEBIAN_FRONTEND=noninteractive apt-get install -y -q git curl build-essential python python-dev python-distribute python-pip && apt-get clean
# Required for building pillow
run DEBIAN_FRONTEND=noninteractive apt-get install -y -q libjpeg8-dev zlib1g-dev libfreetype6-dev liblcms1-dev libwebp-dev libtiff-dev && apt-get clean
# Upgrade pip
run pip --no-input --exists-action=w install --upgrade pip
run curl -L -o /usr/local/bin/app https://raw.github.com/thomasf/docker-djangobuilder/master/content/app 
run chmod 775 /usr/local/bin/app
# insert https://raw.github.com/thomasf/docker-djangobuilder/master/content/git-wrapper /usr/local/bin/git
run echo "cd /var/django-app/" >> /.bash_rc
# expose  8000
cmd ["/usr/local/bin/app", "run"]
