  
# Set the base image to minimized Ubuntu  
#FROM phusion/baseimage  
FROM google/debian:wheezy  
  
VOLUME /storage/mongodb_data  
# Update the repository  
RUN apt-get update && \  
apt-get install -y curl nginx mongodb-server supervisor  
#RUN rm /var/lib/mongodb/mongod.lock  
# RUN service mongodb start  
# Remove the default Nginx configuration file  
RUN rm -v /etc/nginx/nginx.conf  
  
# Copy a configuration file from the current directory  
ADD nginx.conf /etc/nginx/  
  
# Copy supervisord configuration file  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
#RUN chmod -R 777 /var/log/supervisor  
#RUN chmod -R 777 /etc/supervisor  
# RUN adduser vcap sudo; exit 0  
# Append "daemon off;" to the beginning of the configuration  
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
ENV MONGO_URL mongodb://localhost:27017/meteor  
  
  
# Install Meteor  
RUN curl https://install.meteor.com/ | sh  
RUN meteor create --example todos  
WORKDIR /todos  
USER root  
EXPOSE 80 3000  
# Run Meteor and Nginx  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]  

