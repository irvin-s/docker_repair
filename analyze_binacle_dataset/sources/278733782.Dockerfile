# Dockerfile used to generate a way to test the plugins behavior on Linux
FROM jenkins/jenkins
USER root
RUN apt-get update && apt-get install -y python2.7 python-pip python3.4 python3-pip && pip install virtualenv && pip3 install virtualenv
RUN python3 -m virtualenv --python=python3 /var/jenkins_home/mananged_virtualenv

