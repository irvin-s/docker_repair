#ifndef DOCKERFILE_BUILDBOT_SLAVE
#define DOCKERFILE_BUILDBOT_SLAVE

#include "Dockerfile.buildbot-common"

#// Install buildbot-slave.

RUN pip install sqlalchemy==0.7.10 buildbot_slave

#// Create buildbot-slave configuration, might need to be 
#// modified by hand to properly find the buildbot-master
#// address.

#define EXPAND_STRINGIFY(arg) STRINGIFY(arg)
#define STRINGIFY(arg) #arg

#ifndef BUILDBOT_SLAVE_MASTER
RUN /sbin/ip route | awk '/default/ { print $3":9989" }' > /home/buildbot/master-host
#else
RUN /bin/echo EXPAND_STRINGIFY(BUILDBOT_SLAVE_MASTER) > "/home/buildbot/master-host"
#endif 

#ifndef BUILDBOT_SLAVE_USERNAME 
#define BUILDBOT_SLAVE_USERNAME example-slave
#endif

#ifndef BUILDBOT_SLAVE_PASSWORD
#define BUILDBOT_SLAVE_PASSWORD pass
#endif

#define COMBINED buildslave create-slave slave $(cat master-host) BUILDBOT_SLAVE_USERNAME BUILDBOT_SLAVE_PASSWORD
RUN cd /home/buildbot; sudo -u admin sh -c EXPAND_STRINGIFY(COMBINED)


#// Create buildbot-slave supervisord entry.

RUN /bin/echo -e "[program:buildbot-slave] \ncommand=twistd --nodaemon --no_save -y buildbot.tac \ndirectory=/home/buildbot/slave \nuser=admin \n" > /etc/supervisor/conf.d/buildbot-slave.conf


#endif // DOCKERFILE_BUILDBOT_SLAVE