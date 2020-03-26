# Image: abacosamples/base-ubu
# Base image for the abaco actor samples.

from ubuntu:16.04

RUN apt-get update && apt-get install -y git bash
RUN apt-get install -y python-setuptools python-dev build-essential python-pip
# once agavepy is updated uncomment these and remove the three below
#ADD requirements.txt /requirements.txt
#RUN pip install -r /requirements.txt

# remove these once agavepy is updated ---------
ADD newreqs.txt /requirements.txt
RUN pip install -r /requirements.txt
ADD agavepy /agavepy
# ----------------------------------------------
