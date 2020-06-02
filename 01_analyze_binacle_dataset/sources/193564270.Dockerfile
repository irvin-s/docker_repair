FROM ghost:1.14.0

ADD adapter.sh /opt/adapter.sh
ADD config_mysql.js /opt/config_mysql.js
ADD config_sqlite.js /opt/config_sqlite.js
RUN chmod +x /opt/adapter.sh

ENTRYPOINT ["/opt/adapter.sh", "/entrypoint.sh"]
CMD ["npm", "start", "--production"]
