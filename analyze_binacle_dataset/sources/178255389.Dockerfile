## Pull base image
FROM runbook/runbook:{{ git_branch }}

MAINTAINER Benjamin Cane <ben@bencane.com>

# Install required packages
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y stunnel supervisor nginx uwsgi uwsgi-plugin-python git
RUN rm -rf /var/lib/apt/lists/*

RUN useradd -g users runapp

# Create working directories
RUN mkdir -p /code /config /data
RUN mkdir -p /data/runstatic/public_html

# Copy Configurations
ADD config/web.cfg /src/web/instance/web.cfg
ADD config/stunnel-client.conf /config/stunnel-client.conf
ADD config/supervisord.conf /config/supervisord.conf
ADD config/ssl/key.pem /config/key.pem
ADD config/ssl/cert.pem /config/cert.pem
ADD config/nginx/nginx.conf /etc/nginx/nginx.conf
ADD config/nginx/conf.d/uwsgi.conf /etc/nginx/conf.d/uwsgi.conf
ADD config/nginx/globals/htmlglobal.conf /etc/nginx/globals/htmlglobal.conf
ADD config/nginx/globals/uwsgi.conf /etc/nginx/globals/uwsgi.conf
ADD config/nginx/sites-enabled/dash.runbook.io.conf /etc/nginx/sites-enabled/dash.runbook.io.conf
ADD config/nginx/sites-enabled/dash.cloudrout.es.conf /etc/nginx/sites-enabled/dash.cloudrout.es.conf
ADD config/nginx/sites-enabled/cloudrout.es.conf /etc/nginx/sites-enabled/cloudrout.es.conf
ADD config/nginx/sites-enabled/runbook.io.conf /etc/nginx/sites-enabled/runbook.io.conf
ADD config/uwsgi.cfg /config/uwsgi.cfg
ADD config/genstatic.py /code/genstatic.py

# Install requirements
RUN chown -R runapp:users /code /config /data/runstatic /src/web

RUN git clone https://github.com/Runbook/runbook.io.git --branch {{ git_branch }}
RUN cp -R runbook.io/* /

RUN cp -R /src/web/static /data/runstatic/public_html/

# Command to run
CMD /usr/bin/supervisord -c /config/supervisord.conf
