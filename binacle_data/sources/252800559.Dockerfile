# A modern and intuitive terminal-based text editor  
FROM golang:1.8-alpine  
  
MAINTAINER donderom https://hub.docker.com/u/donderom  
  
ENV TERM xterm-256color  
  
RUN apk --update add make git xclip \  
&& go get -d github.com/zyedidia/micro/cmd/micro \  
&& cd $GOPATH/src/github.com/zyedidia/micro \  
&& make install  
  
WORKDIR /tmp  
  
ENTRYPOINT ["micro"]  
  
CMD ["--help"]  

