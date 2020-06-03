FROM kobotoolbox/base-dkobo:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

COPY docker/run_wsgi /etc/service/wsgi/run
COPY docker/*.sh docker/koboform.ini /srv/src/

RUN chmod +x /etc/service/wsgi/run && \
    chown -R wsgi /srv/src/koboform

# Using `/etc/profile.d/` as a repository for non-hard-coded environment variable overrides.
RUN echo 'source /etc/profile' >> /root/.bashrc

USER wsgi

# Using `/etc/profile.d/` as a repository for non-hard-coded environment variable overrides.
RUN echo 'source /etc/profile' >> ~/.bashrc

RUN cd /srv/src/koboform && \
    bower install --config.interactive=false && \
    npm --no-color install --save-dev

COPY . /srv/src/koboform/
COPY ./docker/init.bash /etc/my_init.d/10_init_dkobo.bash
COPY ./docker/sync_static.bash /etc/my_init.d/11_sync_static.bash
#COPY ./docker/create_demo_user.bash /etc/my_init.d/12_create_demo_user.bash

USER root

VOLUME ["/srv/src/koboform"]

EXPOSE 8000

CMD ["/sbin/my_init"]
