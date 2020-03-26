FROM fedora:28

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "LC_CTYPE=en_US.UTF-8" >> /etc/environment

#RUN dnf install wget -y

RUN dnf --setopt=deltarpm=false update -y

RUN dnf install dnf-plugins-core -y

RUN dnf install mc gcc gcc-c++ libaio kernel-devel pcre-devel openssl openssl-devel telnet tar bzip2 htop unzip make sudo wget git -y

# Copy install files
COPY ./install /install

# Install Nginx
RUN /install/nginx.sh

# Install PHP
RUN /install/php.sh

RUN rm -rf /var/www/*

VOLUME /var/www
WORKDIR /var/www

COPY run.sh /run.sh

# Expose ports
EXPOSE 443 80

# Run command
CMD ["/run.sh"]
