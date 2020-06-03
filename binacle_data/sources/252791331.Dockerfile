FROM java:8-jre  
# openjdk:7  
# openjdk-8-jre  
MAINTAINER chihpin@users.noreply.github.com  
  
ENV SPIDER_HOME /usr/local/spider  
ENV SPIDER_WWW /usr/local/spider/www  
ENV PATH $SPIDER_HOME:$SPIDER_HOME/scripts:$PATH  
  
RUN mkdir -p $SPIDER_HOME $SPIDER_WWW  
  
WORKDIR $SPIDER_HOME  
  
COPY . $SPIDER_HOME  
  
# RUN apk update && apk add bash && rm /var/cache/apk/* \  
# && chmod +x $SPIDER_HOME/scripts/spider_config.sh  
# RUN apt-get update && apt-get install -y --no-install-recommends \  
RUN chmod +x $SPIDER_HOME/scripts/spider_config.sh  
  
ENV YIDU_DB_HOST="localhost" \  
YIDU_DB_PORT="5432" \  
YIDU_DB_NAME="yidu" \  
YIDU_DB_USER="postgres" \  
YIDU_DB_PWD="postgres"  
# -rule demo.xml -ca  
# -rule demo.xml -c 1-78000  
ENV SPIDER_RULE='hk020.com' \  
SPIDER_SITE_NAME='52YIDU' \  
SPIDER_SITE_HOST='http://localhost:8080' \  
SPIDER_RUN='-c 1-78000'  
ENV SPIDER_TXT=books/txt \  
SPIDER_COVER=books/cover  
  
CMD ["start.sh"]

