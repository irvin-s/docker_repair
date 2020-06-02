FROM mysql
MAINTAINER team@breizhcamp.org

ADD backup.sh /backup.sh

CMD ["sh", "backup.sh"]
