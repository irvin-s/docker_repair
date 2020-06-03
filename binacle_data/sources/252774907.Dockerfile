FROM alpine  
MAINTAINER Bruno Bigras <bigras.bruno@gmail.com>  
  
RUN apk add --no-cache --virtual .build-deps \  
weechat \  
&& rm -rf /var/cache/apk/*  
  
ENV HOME /weechat  
  
RUN mkdir -p $HOME/.weechat\  
&& addgroup -S weechat\  
&& adduser -D -S -h $HOME -s /sbin/nologin -G weechat weechat \  
&& chown -R weechat:weechat $HOME  
  
VOLUME /weechat/.weechat  
EXPOSE 9001  
WORKDIR $HOME  
USER weechat  
  
CMD ["weechat"]  

