FROM debian:stretch-slim  
MAINTAINER Xavier Priour <xavier.priour@assetsagacity.com>  
  
ARG APP_USER=meteor  
ARG APP_USER_DIR=/home/${APP_USER}  
  
# add packages for building NPM modules (required by Meteor)  
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \  
build-essential \  
curl \  
git \  
python \  
&& apt-get autoremove \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# create a non-root user that can write to /usr/local (required by Meteor)  
RUN useradd -mUd ${APP_USER_DIR} ${APP_USER}  
RUN chown -Rh ${APP_USER} /usr/local  
USER ${APP_USER}  
  
# install Meteor  
RUN curl https://install.meteor.com/ | sh  
# copy files needed to init the repo  
COPY ./src/bin /usr/local/bin  
COPY ./src/app $APP_USER_DIR  
  
# run Meteor from the app directory  
WORKDIR "/app"  
  
# meteor app listens to that port  
EXPOSE 3000  
# application code - mount project root there  
VOLUME "/app"  
# meteor user home - optionally mount to cache meteor files between builds  
VOLUME "/home/meteor"  
# default command: meteor server  
CMD [ "/usr/local/bin/server" ]

