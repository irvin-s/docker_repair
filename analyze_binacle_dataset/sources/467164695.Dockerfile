FROM m0t0k1ch1/mmpc-child-base:v0.3.2

RUN apk --update add bash

WORKDIR /root

ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh ./
RUN chmod +x ./wait-for-it.sh

RUN mkdir -p /var/lib/mmpc /usr/local/etc/mmpc

COPY ./app/config.json /usr/local/etc/mmpc/
COPY ./cli/config.json ./

ENV PLASMA_CLI_CONFIG /root/config.json

ENTRYPOINT ["/root/wait-for-it.sh", "root:8545", "--", "more-minimal-plasma-chain"]
CMD ["--conf", "/usr/local/etc/mmpc/config.json"]
