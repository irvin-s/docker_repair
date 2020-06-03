#  
# doomkin/nginx Dockerfile  
#  
# https://github.com/doomkin/nginx  
#  
# Based on:  
# https://github.com/doomkin/ubuntu-ssh  
#  
FROM doomkin/ubuntu-ssh  
MAINTAINER Pavel Nikitin <p.doomkin@ya.ru>  
  
# Set the noninteractive frontend  
ENV DEBIAN_FRONTEND noninteractive  
  
# Add self signed certificate and insecure key  
ADD certs/nginx.crt /etc/nginx/certs/nginx.crt  
ADD certs/nginx.key /etc/nginx/certs/nginx.key  
  
# Add default redirection to SSL for localhost  
ADD sites-available/default /etc/nginx/sites-available/default  
  
# Build image  
RUN echo "Updating packages..."; \  
apt-get update && apt-get upgrade -y; \  
echo "Installing Nginx..."; \  
apt-get install -y nginx; \  
chown -R www-data:www-data /var/lib/nginx; \  
echo "Cleaning..."; \  
rm -rf /var/lib/apt/lists/*  
  
# Expose http(s) ports  
EXPOSE 22 80 443  
# Startup  
CMD service nginx start && \  
/usr/sbin/sshd -D  

