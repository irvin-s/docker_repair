# UnrealIRCd Dockerfile  
# docker run --name ircd -p 6667:6667 \  
# -p 6697:6697 -p 6090:6090 \  
# -v $(pwd)/unreal:/home/ircd/unrealircd/conf \  
# --rm -it -d c0dy/unrealircd  
FROM debian:stretch  
LABEL maintainer "Cody Zacharias <codyzacharias@pm.me>"  
  
# Upgrade  
RUN apt-get update && \  
apt-get upgrade -y  
  
ENV HOME /home/ircd  
  
# Create Unprivileged User  
RUN mkdir -p $HOME && \  
adduser --disabled-password --shell /bin/sh --home $HOME ircd && \  
chown -R ircd:ircd $HOME  
  
# Install Dependencies  
RUN apt-get install -y \  
wget \  
build-essential \  
libssl-dev  
  
USER ircd  
WORKDIR $HOME  
  
ENV UNREAL_VERSION 4.0.17  
# Install UnrealIRCd  
RUN wget --no-check-certificate \  
\--trust-server-names \  
https://www.unrealircd.org/downloads/unrealircd-latest.tar.gz && \  
tar xzvf unrealircd-$UNREAL_VERSION.tar.gz && \  
cd unrealircd-$UNREAL_VERSION && \  
./Config -nointro \  
&& \  
make && \  
make install  
  
# Clean  
RUN rm unrealircd-$UNREAL_VERSION.tar.gz && \  
rm -rf unrealircd-$UNREAL_VERSION  
  
# Start Scripts  
COPY start_services.sh .  
  
USER root  
  
# Removing dependencies.  
RUN apt-get remove -y \  
wget \  
build-essential && \  
apt autoremove -y && \  
chown -R ircd:ircd /home/ircd  
  
USER ircd  
  
RUN chmod 775 start_services.sh  
  
# Ports to Expose  
EXPOSE 6667  
EXPOSE 6697  
EXPOSE 6090  
CMD ["./start_services.sh"]  

