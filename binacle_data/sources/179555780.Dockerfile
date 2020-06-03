FROM node:7.6.0

MAINTAINER rinke.hoekstra@vu.nl

ENV QBER_APP="/usr/local/qber"


RUN mkdir -p ${QBER_APP}
WORKDIR ${QBER_APP}

COPY package.json ${QBER_APP}
COPY gulpfile.js ${QBER_APP}
COPY src ${QBER_APP}/src

RUN npm install && npm run build

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh


ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["app:start"]
EXPOSE 8000
