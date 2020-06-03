# Run ZNC in a container  
# docker run -d -p 127.0.0.1:6697:6697 --name znc craighurley/docker-znc  
FROM alpine:latest  
MAINTAINER Craig Hurley  
  
ENV LANG C.UTF-8  
ENV HOME /home/user  
RUN apk update \  
&& apk add znc \  
&& rm -rf /var/cache/apk/*  
  
RUN adduser -D -h $HOME user \  
&& mkdir -p $HOME/.znc/configs  
  
COPY ./znc.conf $HOME/.znc/configs/  
  
RUN znc --makepem --datadir $HOME/.znc \  
&& chown -R user:user $HOME  
  
EXPOSE 6697  
WORKDIR $HOME  
  
VOLUME [ "$HOME/.znc" ]  
  
USER user  
# Start the ZNC process and leave it running in the foreground.  
CMD [ "znc", "--foreground", "--datadir", "/home/user/.znc" ]  

