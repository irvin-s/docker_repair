FROM node:7-slim

EXPOSE 4567
ENTRYPOINT ["kinesalite", "--createStreamMs=20", "--deleteStreamMs=20", "--updateStreamMs=20"]

# add a non-privileged user for installing and running
# the application
RUN groupadd -g 10001 app && \
    useradd -d /app -g 10001 -G app -M -s /bin/sh -u 10001 app

RUN mkdir -p /app && chown -R app:app /app

USER app
WORKDIR /app

RUN npm install -d kinesalite && npm dedupe
ENV PATH=$PATH:/app/node_modules/.bin/
