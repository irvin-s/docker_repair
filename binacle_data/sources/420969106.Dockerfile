FROM cwds/alpinejre
RUN mkdir /opt/cws-api
RUN mkdir /opt/cws-api/logs
ADD config/api.yml /opt/cws-api/api.yml
ADD config/shiro.ini /opt/cws-api/config/shiro.ini
ADD config/enc.jceks /opt/cws-api/config/enc.jceks
ADD build/libs/api-dist.jar /opt/cws-api/api.jar
ADD entrypoint.sh /opt/cws-api/entrypoint.sh
EXPOSE 8080
EXPOSE 8081
RUN chmod +x /opt/cws-api/entrypoint.sh
WORKDIR /opt/cws-api
CMD ["/opt/cws-api/entrypoint.sh"]
