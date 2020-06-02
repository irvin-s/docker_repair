FROM alpine
ADD docker-entrypoint.sh /
RUN chmod +x docker-entrypoint.sh
ADD k8guard-discover /
EXPOSE 3000
ENTRYPOINT ["/docker-entrypoint.sh"]
