FROM golang:1.8  
MAINTAINER https://github.com/andersfylling  
  
WORKDIR /go/src/github.com/andersfylling/rolerboler  
COPY . .  
  
# Get Glide for package management  
RUN curl https://glide.sh/get | sh  
RUN glide install  
  
ENV ROLERBOLER_CLIENTID 0  
ENV ROLERBOLER_COMMANDPREFIX 0  
ENV ROLERBOLER_TOKEN 0  

