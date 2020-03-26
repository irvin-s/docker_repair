from ubuntu:14.04

# Update the repository
RUN apt-get update

# Install necessary tools
RUN apt-get install -y nano wget dialog net-tools

# Download and Install Nginx
RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Replace config file with our own
ADD nginx.conf /etc/nginx/nginx.conf
RUN mkdir /tmp/nginx

# Add the run script to start nginx
ADD run.sh /tmp/nginx/run.sh
RUN chmod +x /tmp/nginx/run.sh

# Expose ports
EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD /tmp/nginx/run.sh
