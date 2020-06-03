FROM alpine

RUN apk add --no-cache bash
RUN apk add --no-cache curl
RUN apk add --no-cache sed

COPY pipeline-create.sh ./pipeline-create.sh

CMD bash ./pipeline-create.sh

