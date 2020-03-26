FROM jboss/wildfly:10.1.0.Final

###
# Environment variables
#
# SERVER_SECURE
#   If 'secure' is set to 'true' it will use WSS, defaults to false/WS
# SERVER_ADDRESS
#   WS server address. If not defined, it will default to the same as webapp host name
# SERVER_PORT
#   WS server port. If not defined, it will default to 5082
# SERVER_SECURE_PORT
#   WSS secure server port. If not defined, it will default to 5083
# SERVER_PATH
#   WS path to use in WS(S) url. If not defined, a default value will NOT be provided
# CLIENT_REGISTER
#   If 'register' is set to 'false' will use registerless mode, defaults to true
# CLIENT_DOMAIN
#   Domain to be used in the SIP URI <user>@<domain>. If not defined, it will default to the webapp host name
# CLIENT_USER_AGENT
#   User Agent string. If not defined, it will default to 'TelScale RTM Olympus'. '/<version>' is appended
# STUN_ENABLED
#   STUN configuration. Only used if 'enabled' is set to 'true'
# STUN_ADDRESS
#   STUN server address. If not defined, it will default to 'stun.l.google.com'
# STUN_PORT
#   STUN server port. If not defined, it will default to '19302'
# TURN_ENABLED
#   TURN configuration. Only used if 'enabled' is set to 'true'
# TURN_ADDRESS
#   TURN server address. If not defined, it will default to 'https://global.xirsys.net/_turn'
# TURN_DOMAIN
#   TURN domain. If not defined, a default value will NOT be provided
# TURN_LOGIN
#   TURN login. If not defined, a default value will NOT be provided
# TURN_PASSWORD
#   TURN password. If not defined, a default value will NOT be provided
# CANDIDATE_TIMEOUT
#   Timeout waiting for ICE candidates. If not defined a value of 0 is used, meaning no timeout
#
# Note, JBOSS will start on port 8080 by default only on the instance's IP
#
# Start with: docker run -it [-e ENV_VAR=VALUE]* --name rc-olympus restcomm/olympus



# User root user to install software
USER root

RUN yum -y update && yum clean all
RUN yum install -y wget
RUN echo $JBOSS_HOME
RUN rm -rf $JBOSS_HOME/standalone/deployments/ROOT.war

ADD docker/bootstrap.sh ./bootstrap.sh
ADD docker/config-wildfly.py ./config-wildfly.py
ADD docker/process-config.py ./process-config.py
ADD target/olympus.war ./olympus.war
RUN unzip -q ./olympus.war -d $JBOSS_HOME/standalone/deployments/olympus.war
RUN python ./process-config.py
RUN touch $JBOSS_HOME/standalone/deployments/olympus.war.dodeploy

# EXPOSE 8080

RUN echo "run ./bootstrap.sh"
CMD ["./bootstrap.sh"]