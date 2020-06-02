# Includes buildpack-deps:jessie (Debian with Tools)  
FROM python:2-onbuild  
MAINTAINER Matteo De Paoli <depaoli@>  
  
#  
# Flask App Server  
#  
ADD FlaskAppServer /FlaskAppServer  
WORKDIR /FlaskAppServer  
  
CMD [ "bash", "bin/run.sh" ]  

