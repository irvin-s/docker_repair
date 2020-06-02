# This Dockerfile based on dockerana/dockerana
FROM nacyot/ubuntu
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

# Install Base Packages
RUN apt-get -y update
RUN apt-get -y install supervisor nginx-light
RUN apt-get -y install python-simplejson python-memcache python-ldap python-cairo \
                       python-twisted python-pysqlite2 python-support \
                       python-pip gunicorn

# Install python packages
RUN pip install pytz pyparsing django==1.5 django-tagging==0.3.1

# Install whisper and graphite-web
WORKDIR /usr/local/src
RUN git clone https://github.com/graphite-project/whisper.git
RUN cd whisper && git checkout 0.9.12 && python setup.py install
RUN git clone https://github.com/graphite-project/graphite-web.git
RUN cd graphite-web && \
        git checkout 0.9.12 && \
        python check-dependencies.py && python setup.py install

# Setup graphite directories and environment variables
ENV GRAPHITE_STORAGE_DIR /opt/graphite/storage
ENV GRAPHITE_CONF_DIR /opt/graphite/conf
ENV PYTHONPATH /opt/graphite/webapp
ENV LOG_DIR /var/log/graphite
ENV DEFAULT_INDEX_TABLESPACE graphite

RUN mkdir -p /opt/graphite/webapp
RUN mkdir -p /var/log/graphite
RUN cd /var/log/graphite/ && touch info.log
RUN mkdir -p /opt/graphite/storage/whisper
RUN touch /opt/graphite/storage/graphite.db /opt/graphite/storage/index
RUN chown -R www-data /opt/graphite/storage
RUN chmod 0775 /opt/graphite/storage /opt/graphite/storage/whisper
RUN chmod 0664 /opt/graphite/storage/graphite.db

# Copy configuration files
ADD ./config/local_settings.py /opt/graphite/webapp/graphite/local_settings.py 
ADD ./config/initial_data.json /opt/graphite/webapp/graphite/initial_data.json
ADD ./config/nginx.conf /etc/nginx/nginx.conf
ADD ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Initialize database(sqlite3)
RUN cd /opt/graphite/webapp/graphite && django-admin.py syncdb --settings=graphite.settings --noinput
RUN cd /opt/graphite/webapp/graphite && django-admin.py loaddata --settings=graphite.settings initial_data.json

# Set CMD
WORKDIR /opt/graphite/webapp
EXPOSE 80
CMD ["/usr/bin/supervisord", "-n"]

