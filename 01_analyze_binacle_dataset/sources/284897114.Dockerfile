FROM redis:5.0.3-alpine

RUN mkdir -p /conf
COPY fix-ip.sh /conf/fix-ip.sh
# ENTRYPOINT ["/conf/fix-ip.sh"]

CMD ["/conf/fix-ip.sh", "redis-server"]
