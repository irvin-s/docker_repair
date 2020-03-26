FROM jboss/wildfly:13.0.0.Final
MAINTAINER BITFORCE-IT GmbH René Mertins r.mertins@bitforce-it.de

# go root to do copy and rights stuff
USER root

# create folders and copy data into
RUN mkdir /start
ADD bin/ /start
ADD customization /opt/jboss/wildfly/customization/
ADD modules/ /opt/jboss/wildfly/modules

# set owner ship and rights
RUN chown -R jboss:jboss /start
RUN chown -R jboss:jboss /opt/jboss/wildfly/modules
RUN chown -R jboss:jboss /opt/jboss/wildfly/customization
RUN chmod 775 /opt/jboss/wildfly/customization/execute.sh
RUN chmod 775 /start/entrypoint.sh

# switch back to app user
USER jboss

# set exposed ports for NAT
EXPOSE 8080
EXPOSE 9990

# provide mount able volume path
VOLUME /data/logs

# setup environment
ENV DB_HOST 10.0.0.1
ENV DB_PORT 3306
ENV DB_USER db_user
ENV DB_PASSWORD db_password
ENV DB_SCHEMA db_schema
ENV AWS_KEY AKXXXXXXXXXXXXXXXXXX
ENV AWS_SECRET fDEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# add management user to jboss wildfly 10 application server
RUN /opt/jboss/wildfly/bin/add-user.sh admin password --silent
# run our app service customization script using standalone mode with standalone.xml configuration
RUN /opt/jboss/wildfly/customization/execute.sh standalone standalone.xml

RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/current

# copy the application
# ADD Application.ear /opt/jboss/wildfly/standalone/deployments/Application.ear

# NOTE!!!
# Do frequently changing stuff at the end of a dockerfile, because if there is no change in previous steps the cache is used.
# Is one step changing something, all following steps have to be redone.

# set the entry point to custom script
ENTRYPOINT ["/start/entrypoint.sh"]

# define pseudo command, which is recognized by entry point script
CMD ["jboss"]
