FROM boinc/server_makeproject:3.0.0-b2d-defaultargs

MAINTAINER Marius Millea <mariusmillea@gmail.com>

# dont need built-in boinc2docker app
RUN rm -rf $PROJECT_ROOT/apps/boinc2docker

# install extra packages
USER root
RUN apt-get update && apt-get install -y --no-install-recommends ruby-kramdown
USER $BOINC_USER

# install camb_legacy
COPY --chown=1000 apps/camb_legacy/ $PROJECT_ROOT

# install boinc2docker_camb
COPY --chown=1000 apps/camb_boinc2docker/ $PROJECT_ROOT
RUN boinc2docker_create_app --projhome $PROJECT_ROOT $PROJECT_ROOT/apps_boinc2docker/camb/boinc2docker.yml

# install lsplitsims
COPY --chown=1000 apps/lsplitsims/ $PROJECT_ROOT
RUN boinc2docker_create_app --projhome $PROJECT_ROOT $PROJECT_ROOT/apps_boinc2docker/lsplitsims/boinc2docker.yml

# project files
COPY --chown=1000 py $PROJECT_ROOT/py
COPY --chown=1000 project.xml config.xml cosmohome.httpd.conf $PROJECT_ROOT/
COPY --chown=1000 boinc/html $PROJECT_ROOT/html
COPY --chown=1000 html $PROJECT_ROOT/html
COPY --chown=1000 bootswatch/cyborg/bootstrap.min.css $PROJECT_ROOT/html/user
COPY --chown=1000 bin $PROJECT_ROOT/bin

# compile markdown files
RUN cd $PROJECT_ROOT/html/user && ./compile_md.py

# finish up
ARG GITTAG
RUN echo $GITTAG > $PROJECT_ROOT/.gittag
