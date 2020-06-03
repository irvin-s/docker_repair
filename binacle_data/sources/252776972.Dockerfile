FROM ubuntu:16.04  
MAINTAINER Matt Snider (matt@cleanenergyexperts.com)  
  
# Updating Apt-get  
RUN apt-get -y update  
  
# Install DBT  
RUN apt-get install -y git libpq-dev python-dev python-pip  
RUN pip install dbt

