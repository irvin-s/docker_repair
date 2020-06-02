FROM alpine:latest  
  
MAINTAINER Janaka Wickramasinghe <janakawicks@gmail.com>>  
  
COPY ["run.sh", "/"]  
  
RUN set -ex \  
\  
&& apk add \--no-cache postfix postfix-pcre rsyslog  
  
EXPOSE 25  
CMD /run.sh  

