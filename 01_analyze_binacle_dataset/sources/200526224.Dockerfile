FROM ubuntu:14.04

ENV SUPERVISOR_VERSION 3.3.1

# Dependencies
RUN apt-get update -y
RUN sudo apt-get install -y software-properties-common
RUN sudo add-apt-repository ppa:vbernat/haproxy-1.6
RUN apt-get update -y
RUN set -x  && \
    sudo apt-get install -y \
        haproxy \
        bc \
        python-setuptools \
        curl && \
    curl -sOL https://github.com/Supervisor/supervisor/archive/${SUPERVISOR_VERSION}.tar.gz \
        && tar -xvf ${SUPERVISOR_VERSION}.tar.gz \
        && cd supervisor-${SUPERVISOR_VERSION} && sudo python setup.py install

# Install
RUN mkdir -p /opt/letsencrypt
RUN curl -sL https://dl.eff.org/certbot-auto > /opt/letsencrypt/certbot-auto
RUN chmod a+x /opt/letsencrypt/certbot-auto
RUN /opt/letsencrypt/certbot-auto --os-packages-only --noninteractive

ADD renew-certificate /usr/local/sbin/renew-certificate
RUN sudo chmod +x /usr/local/sbin/renew-certificate
ADD supervisord.conf /etc/supervisord.conf

# Crontab
ADD crontab /etc/cron.d/renew-certificate-cron
RUN chmod 0644 /etc/cron.d/renew-certificate-cron

EXPOSE 443
EXPOSE 80

CMD ["sh", "-c", "echo \"export DOMAINS='$DOMAINS'; export EMAILS='$EMAIL';\" > /tmp/.docker.env && INITIAL_RENEWAL=true /usr/local/sbin/renew-certificate && supervisord"]
