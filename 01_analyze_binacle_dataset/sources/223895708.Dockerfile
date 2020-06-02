FROM alpine

# Install basic utilities
RUN export http_proxy=http://proxy-wsa.esl.cisco.com:80/ \
  && export https_proxy=http://proxy-wsa.esl.cisco.com:80/ \ 
  && apk add -U docker curl bash mailx \
      msmtp   \
  && rm -rf /var/cache/apk/*

# Add current folder as /app
ADD . /app
WORKDIR /app

COPY mailrc /etc/mail.rc
COPY msmtprc /etc/msmtprc

ENV http_proxy=http://173.38.209.8:80/
ENV https_proxy=http://173.38.209.8:80/
ENV no_proxy=172.17.0.1,10.60.7.20,ilm-room.cisco.com

CMD [ "./roomfinder_monitor/monitor.sh" ]
