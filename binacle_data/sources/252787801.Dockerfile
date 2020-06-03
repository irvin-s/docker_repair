FROM alpine:latest  
ENV SCRIPT_URL=""  
COPY script-runner.sh /script-runner.sh  
RUN apk --no-cache --update add curl ca-certificates samba && \  
chmod +x script-runner.sh  
ENTRYPOINT ["./script-runner.sh"]

