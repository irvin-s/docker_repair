# Booking Calendar  
FROM ubuntu:xenial  
MAINTAINER Andrew McCracken "andrew@tind.io"  
RUN apt-get update -y  
RUN apt-get install -y python-pip python2.7 build-essential  
  
RUN apt-get -qy install --fix-missing --no-install-recommends --force-yes curl  
  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
  
# Install dependencies  
RUN apt-get -qy --force-yes install --fix-missing --no-install-recommends \  
gcc \  
git \  
less \  
nodejs \  
unzip \  
vim \  
sudo \  
libffi6 \  
libffi-dev  
  
COPY . /app  
WORKDIR /app  
  
# Install npm packages  
COPY package.json /app/  
RUN npm install  
  
RUN npm run postinstall  
  
RUN pip install -r requirements.txt  
  
EXPOSE 80  
CMD ["gunicorn", "server:app", "--workers 1", "-b 0.0.0.0:80"]  

