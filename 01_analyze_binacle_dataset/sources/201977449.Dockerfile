FROM       nginx:latest
MAINTAINER Alex Banna alexb@tune.com
ENV        REFRESHED_AT 2015-12-08

# add app env vars
ENV APPNAME nginx
ENV HOME /etc/${APPNAME}
ENV APPS_ROOT /var/tune

# Copy base configuration file from the current directory
ADD ./docker/proxy/nginx.conf ${HOME}/nginx.conf
ADD ./docker/proxy/ff-docs.conf ${HOME}/conf.d/
RUN chown -R nginx:nginx $HOME && \
    rm ${HOME}/conf.d/default.conf && \
    mkdir -p $APPS_ROOT && \
    chown -R nginx:nginx $APPS_ROOT

ENTRYPOINT ["nginx"]
