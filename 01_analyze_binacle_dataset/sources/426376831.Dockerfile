#ifndef DOCKERFILE_BUILDBOT_MASTER
#define DOCKERFILE_BUILDBOT_MASTER

#include "Dockerfile.buildbot-common"

#// Install buildbot-master.

RUN pip install sqlalchemy==0.7.10 buildbot

#// Create buildbot-master configuration.

RUN cd /home/buildbot; sudo -u admin sh -c "buildbot create-master master"
RUN cd /home/buildbot; cp -a master/master.cfg.sample master/master.cfg

#// Create buildbot-master supervisord entry.

RUN /bin/echo -e "[program:buildbot-master] \ncommand=twistd --nodaemon --no_save -y buildbot.tac \ndirectory=/home/buildbot/master \nuser=admin \n" > /etc/supervisor/conf.d/buildbot-master.conf

#// Expose the web interface.
#// Expose the buildbot command port.

EXPOSE :8010
EXPOSE :9989

#endif // DOCKERFILE_BUILDBOT_MASTER