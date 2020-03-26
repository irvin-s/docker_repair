FROM ubuntu:trusty  
  
RUN apt-get update  
  
RUN apt-get install -y build-essential nodejs npm  
RUN ln -s $(which nodejs) /usr/bin/node  
  
RUN apt-get install -y spamassassin spamc  
  
RUn apt-get install -y rsyslog  
  
# Install git, curl, python, and phantomjs  
RUN apt-get install -y git curl python phantomjs  
  
# Make sure we have a directory for the application  
RUN mkdir -p /var/www  
RUN chown -R www-data:www-data /var/www  
  
# Install fibers -- this doesn't seem to do any good, for some reason  
RUN npm install -g fibers  
  
# Install Mailin  
RUN npm install -g mailin  
  
# Install Meteor  
RUN curl https://install.meteor.com/ |sh  
  
# Install entrypoint  
ADD entrypoint.sh /usr/bin/entrypoint.sh  
RUN chmod +x /usr/bin/entrypoint.sh  
  
EXPOSE 80  
EXPOSE 25  
ENTRYPOINT ["/usr/bin/entrypoint.sh"]  
CMD []

