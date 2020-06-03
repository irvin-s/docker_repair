FROM alpine

RUN apk update && apk add bash && rm -rf /var/cache/apk/*

CMD [ "/bin/bash" ]
