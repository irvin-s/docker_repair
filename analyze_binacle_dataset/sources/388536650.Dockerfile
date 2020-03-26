FROM gregmd/homestead

RUN dnf install php-bcmath -y

ADD ./build-deploy/nginx/ssl /etc/nginx/ssl

ADD ./build-deploy/nginx/domains.d /etc/nginx/domains.d

# Install and configure AWS CLI
RUN pip install awscli --upgrade --user

RUN echo "export PATH=~/.local/bin:\$PATH" >> /root/.bashrc

ADD ./aws-credentials /root/.aws/credentials

# ADD current files
ADD . /var/www/app

WORKDIR /var/www/app

RUN composer install

HEALTHCHECK NONE

# Expose ports
EXPOSE 443 80

# Run command
CMD ["./build-deploy/run.sh"]
