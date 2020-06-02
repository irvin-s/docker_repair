FROM alpine:latest
RUN apk --no-cache add curl
COPY wrapper.sh /wrapper.sh

CMD /wrapper.sh
