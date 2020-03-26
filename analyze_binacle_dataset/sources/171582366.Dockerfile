FROM node:0.10.33

WORKDIR /app

ADD package.json /app/package.json
RUN npm install

ADD bin /app/bin
ADD lib /app/lib
ADD test /app/test

ADD example/export.json /app/example/export.json

RUN mkdir db
RUN npm test

# Asana user=asanabot@importsandbox.alexd-test-subdomain.asana.com password=a5anab0t
ENV ASANA_API_KEY 5PUmeLPC.tJAE8kFo3vduEtXW9kSgw8x
ENV ASANA_ORGANIZATION 20556533848969

CMD bin/asana_export_importer --api-key=$ASANA_API_KEY --organization=$ASANA_ORGANIZATION /app/example/export.json
