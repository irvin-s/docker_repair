FROM codeserver/base  
MAINTAINER hello@neilellis.me  
COPY gitpoll.sh /etc/service/gitpoll/run  
COPY update_app.sh /usr/local/bin/  
RUN chmod 755 /etc/service/gitpoll/run /usr/local/bin/*  
ENV GITHUB_USER neilellis  
ENV GITHUB_PROJECT codeserver-example  
ENV GITHUB_BRANCH master  

