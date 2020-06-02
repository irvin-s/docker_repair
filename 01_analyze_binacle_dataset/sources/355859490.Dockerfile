FROM alpine:3.5

MAINTAINER fengqi lyf362345@gmail.com

ENV NGROK /opt/ngrok
ENV DOMAIN lanout.tk

EXPOSE 80 443 4443

COPY run.sh $NGROK/
COPY ngrok/bin/ngrokd $NGROK/
COPY lanout.tk.crt $NGROK/ssl.crt
COPY lanout.tk.key $NGROK/ssl.key

RUN chmod +x $NGROK/run.sh

CMD $NGROK/run.sh

