FROM alpine

RUN apk update && apk add bind-tools && rm -rf /var/cache/apk/*

CMD [ "/bin/bash" ]
