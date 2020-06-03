FROM gliderlabs/alpine:edge  
  
MAINTAINER Geoff Bowers <modius@daemon.com.au>  
  
ENV SLACK_HOOK='https://hooks.slack.com/services/YOUR/HOOK/HERE'  
ENV RELAY_PORT=80  
ENV VIRTUAL_HOST='slack-relay.dev'  
RUN apk add --update \  
python \  
py-requests \  
py-twisted \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir /app  
COPY code /app  
WORKDIR /app  
  
EXPOSE 80  
CMD ["python", "relay.py"]

