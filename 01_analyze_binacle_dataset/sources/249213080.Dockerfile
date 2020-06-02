FROM gliderlabs/alpine

RUN apk-install bash

COPY ./../../../images/led/logger.sh  /
COPY ./start.sh /

RUN sed -i 's/\r$//' /start.sh && chmod +x /start.sh \
    && sed -i 's/\r$//' /logger.sh && chmod +x /logger.sh

CMD ["/bin/bash","start.sh"]
