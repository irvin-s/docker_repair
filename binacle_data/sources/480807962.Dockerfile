FROM registry.ng.bluemix.net/ibmliberty
RUN installUtility install --acceptLicense mongodb-2.0
COPY mongoDBSample /opt/ibm/wlp/usr/servers/defaultServer
