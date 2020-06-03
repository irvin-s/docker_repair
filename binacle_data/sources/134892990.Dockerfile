from debian:latest

run export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
    locales \
    mariadb-client \
    python-pip \
    python-mysqldb \
    wget

run sed -i 's/# nb_NO.UTF-8/nb_NO.UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

run pip install flask

# atelier itself
copy src/main/python /opt/atelier
copy src/main/bash/atelier-endpoint /usr/sbin/
copy src/main/mysql /var/spool/atelier

# atelier's static dependencies
run mkdir -p /opt/atelier/files/js

#     wget https://raw.githubusercontent.com/nnnick/Chart.js/master/Chart.js \
# -O /opt/atelier/files/js/Chart.js

cmd /usr/sbin/atelier-endpoint
