FROM ten7/dockstack-php-apache:latest
MAINTAINER tess@deninet.com

COPY ansible/ /ansible/
RUN ansible-playbook -i /ansible/inventory/dropwhale /ansible/build.yml
