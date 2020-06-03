FROM python:2.7.14-slim

RUN mkdir -p /usr/src/app 

# Install needed packages
RUN apt-get update \
  && apt-get install -y \
  gcc \
  zip 

# Install pip dependencies
RUN pip install virtualenv 

WORKDIR /usr/src/app

COPY ./build-deployment-package.sh /

ENTRYPOINT ["/bin/bash", "/build-deployment-package.sh"]
