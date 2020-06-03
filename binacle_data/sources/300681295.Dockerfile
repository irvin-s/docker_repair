FROM cwds/javajdk
RUN mkdir /opt/cals-api-tests
ADD cals-api-tests.jar /opt/cals-api-tests/cals-api-tests.jar
ADD resources /opt/cals-api-tests/resources
ADD config /opt/cals-api-tests/config
ADD entrypoint.sh /opt/cals-api-tests/
RUN chmod +x /opt/cals-api-tests/entrypoint.sh
WORKDIR /opt/cals-api-tests
CMD ["/opt/cals-api-tests/entrypoint.sh"]
