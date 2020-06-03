#------------------------------------------------------------------------------
# Dockerized Redcap for deploying in a variety of environments
#------------------------------------------------------------------------------

#The Containers in the System:
# 1) [afolarin/redcap:mysql] 
# 2) [afolarin/redcap:webapp]
# 3) [afolarin/redcap:cron]

# USAGE:
# docker run -d --name="redcap-cron" -v $(pwd)/cron-conf:/cron --volumes-from="redcap-web" afolarin/redcap:cron

#------------------------------------------------------------------------------
# Cron Container -- redcap requires a cron process to run /app/redcap/cron.php
# redcap folder is exposed as a volume by the redcap-web container, inside is
# is /redcap/cron.php. The crontab file (crontab) is in the mounted host folder 
# cron/cron-conf this is passed to the containers devcron process
# 
#------------------------------------------------------------------------------

FROM python:2.7

MAINTAINER Amos Folarin <amosfolarin@gmail.com>

# Need hg to download devcron
RUN apt-get update && apt-get install -y mercurial

#install devcron, there are issues running crontab in a docker container
RUN pip install -e hg+https://bitbucket.org/dbenamy/devcron#egg=devcron

#setup php alternatives to point to php5
RUN ln -s -T /usr/bin/php5 /etc/alternatives/php

# Setup defaults
RUN mkdir /cron && \
    echo "* * * * * /cron/sample.sh" > /cron/crontab && \
    echo "echo hello world" > /cron/sample.sh && \
    chmod a+x /cron/sample.sh

#VOLUME ["/cron"]

CMD ["devcron.py", "/cron/crontab"]
