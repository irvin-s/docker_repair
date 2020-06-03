FROM mysql:latest
ADD start.sh start.sh
RUN chmod 755 /start.sh
ENTRYPOINT ["/start.sh"]
EXPOSE 3306
