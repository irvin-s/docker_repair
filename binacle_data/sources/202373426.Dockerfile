FROM phusion/baseimage:0.9.18

MAINTAINER Samuel Cozannet <samuel.cozannet@madeden.com>
LABEL version="1.0.0"
LABEL app="pubsub-emulator"

ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV DATA_DIR "/data"
ENV HOST_PORT 8042

RUN apt-get update && \
	apt-get install -yqq curl \
		python \
		openjdk-7-jre && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

RUN \
	curl https://sdk.cloud.google.com | bash && \
 	cat /root/google-cloud-sdk/path.bash.inc | bash && \
 	cat /root/google-cloud-sdk/completion.bash.inc | bash && \
 	/root/google-cloud-sdk/bin/gcloud components install -q pubsub-emulator beta

RUN mkdir ${DATA_DIR}

ADD start-pubsub /etc/my_init.d/00_start-pubsub

RUN chmod +x /etc/my_init.d/00_start-pubsub

CMD ["/sbin/my_init"]

EXPOSE 8042

