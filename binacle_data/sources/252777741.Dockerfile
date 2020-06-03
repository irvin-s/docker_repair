FROM alpine:edge  
  
MAINTAINER Antón R. Yuste  
  
RUN apk --update add \  
ca-certificates \  
ruby \  
ruby-bundler \  
ruby-dev && \  
rm -fr /usr/share/ri  
  
RUN apk add --no-cache make gcc libc-dev git ncurses less && \  
rm -fr /usr/share/ri  
  
# See https://github.com/stephencelis/ghi/blob/master/README.md#install  
RUN gem install ghi --no-rdoc --no-ri  
  
# User ghi instead of root  
RUN adduser -D -g '' ghi  
USER ghi  
WORKDIR /home/ghi  
VOLUME /home/ghi  
  
ENTRYPOINT ["/usr/bin/ghi"]  

