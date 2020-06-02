FROM osf_scraper_base

# different builds for different environment
ARG BUILD_ENV
RUN echo "++ building Dockerfile for env: ${BUILD_ENV}"

# constants
ENV APP_NAME osf_scraper_api
ENV REPO_URL git@github.com:mhfowler/open-source-feeds.git
ENV REPO_REMOTE origin
ENV PUBLIC_DIR /srv/public
ENV SRC_DIR /srv/app
ENV WDIR /srv/app/osf_scraper_api
ENV BASE_DIR .
ENV DEVOPS_DIR $BASEDIR/osf_scraper_api/devops
ENV ENV_PATH "${LOCAL_DIR}/devops/secret_files/env/${BUILD_ENV}"

# copy over nginx conf
COPY ${DEVOPS_DIR}/build/nginx.conf /etc/nginx/nginx.conf
COPY ${DEVOPS_DIR}/build/nginx_site.conf /etc/nginx/sites-available/app.conf
RUN rm /etc/nginx/sites-enabled/*
RUN ln -s \
    /etc/nginx/sites-available/app.conf \
    /etc/nginx/sites-enabled/app.conf

# copy code
COPY $BASEDIR/osf_scraper_api/osf_scraper_api $SRC_DIR/osf_scraper_api
COPY $BASEDIR/osf/osf $SRC_DIR/osf

# copy hellow_webapp.ini
COPY ${DEVOPS_DIR}/build/app.ini "${SRC_DIR}/app.ini"

# copy env.json
RUN echo "++ env_path: "$ENV_PATH
RUN rm "${WDIR}/env.json"
COPY $ENV_PATH "${WDIR}/env.json"

# set file permissions
RUN chgrp -R webgroup /srv
RUN chmod -R u=rwX,g=rwX,o=X /srv

# install python requirements
RUN pip install -r "${SRC_DIR}/osf_scraper_api/requirements.txt"

# Expose ports for nginx
EXPOSE 80 443

# start app
CMD (supervisord -c /etc/supervisor/conf.d/supervisord.conf)