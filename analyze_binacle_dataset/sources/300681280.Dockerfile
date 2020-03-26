FROM cwds/alpinejre
RUN mkdir /opt/cals-api
RUN mkdir /opt/cals-api/logs
ADD config/*.yml /opt/cals-api/
ADD config/shiro.ini /opt/cals-api/config/shiro.ini
ADD config/testKeyStore.jks /opt/cals-api/config/testKeyStore.jks
ADD config/enc.jceks /opt/cals-api/config/enc.jceks
ADD build/libs/cals-api-dist.jar /opt/cals-api/cals-api.jar
ADD build/entrypoint.sh /opt/cals-api/
ADD version.txt /opt/cals-api/version.txt
ADD src/main/resources/dms /opt/cals-api/dms
EXPOSE 8080 8443
RUN chmod +x /opt/cals-api/entrypoint.sh
WORKDIR /opt/cals-api
CMD ["/opt/cals-api/entrypoint.sh"]