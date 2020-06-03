FROM phusion/baseimage:0.9.18  
MAINTAINER Blake Harley <blake@blakeharley.com>  
  
# Use Phusion  
CMD ["/sbin/my_init"]  
  
# Copy the cron job  
COPY res/cron /etc/cron.d/scraper  
RUN chmod 600 /etc/cron.d/scraper  
  
# Install Nodejs  
RUN apt-get update  
RUN apt-get -y install xz-utils wget  
WORKDIR /opt/node  
RUN wget https://nodejs.org/dist/v4.4.4/node-v4.4.4-linux-x64.tar.xz  
RUN tar -C /usr --strip-components 1 -xJf node-v4.4.4-linux-x64.tar.xz  
  
# Install the project  
RUN mkdir /opt/scraper  
COPY package.json /opt/scraper/  
COPY scraper.coffee /opt/scraper/  
WORKDIR /opt/scraper  
RUN npm install  
  
# Clean up APT  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

