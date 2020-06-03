#  
# DesertBit Bulldozer Dockerfile  
#  
FROM golang  
  
MAINTAINER Roland Singer, roland.singer@desertbit.com  
  
ENV BULLDOZER_DATA_DIR "/data/files"  
ENV BULLDOZER_SESSIONS_DB_PATH "/data/sessions.db"  
ENV BULLDOZER_DB_ADDR "ENV:DB_PORT_28015_TCP_ADDR"  
ENV BULLDOZER_DB_PORT "ENV:DB_PORT_28015_TCP_PORT"  
# Install dependencies  
RUN export DEBIAN_FRONTEND=noninteractive; \  
apt-get update && \  
apt-get install -y rubygems && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
gem install sass  
  
# Add the bulldozer user, prepare the data directory and fix permission.  
ADD run.sh /run.sh  
RUN useradd --no-create-home bud  
RUN mkdir /data  
RUN chown -R bud:bud /data /go && \  
chmod -R 770 /go /data && \  
chmod +x /run.sh  
  
RUN mkdir -p /go/src/app  
WORKDIR /go/src/app  
  
# On build triggers  
ONBUILD COPY . /go/src/app  
ONBUILD RUN go-wrapper download  
ONBUILD RUN go-wrapper install  
ONBUILD RUN chown -R bud:bud /go && \  
chmod -R 770 /go  
  
EXPOSE 9000  
VOLUME [ "/data" ]  
  
CMD [ "/run.sh", "go-wrapper", "run", "-settings", "/data/settings.toml" ]

