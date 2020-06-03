FROM debian:8  
LABEL maintainer="Alexandre Buisine <alexandrejabuisine@gmail.com>"  
LABEL version="0.9.1"  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \  
&& apt-get install -yqq --no-install-recommends \  
curl \  
unzip \  
mongodb-server \  
openjdk-7-jre-headless \  
&& apt-get -yqq clean \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /home  
RUN curl -Lkso mfi.zip https://dl.ubnt.com/mfi/2.1.11/mFi.unix.zip \  
&& unzip mfi.zip \  
&& rm mfi.zip  
  
WORKDIR /home/mFi  
VOLUME /home/mFi/data  
  
EXPOSE 6080 6443 6880 6843  
ENV JAVA_OPTS="-Xmx1G"  
ENTRYPOINT ["java", "-jar", "lib/ace.jar"]  
CMD ["start"]

