# HAProxy for MySQL
# docker run --rm -p 3306:3306 -e MYSQL_ENDPOINT=mysql.local:3306 supinf/haproxy:1.8-mysql

FROM haproxy:1.8.13-alpine

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
