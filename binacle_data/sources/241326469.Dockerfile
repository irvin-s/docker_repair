# swagger-mock-api v1.6.0
#
# docker run --rm -p 80:8000 supinf/swagger-mock-api:1.6
# docker run --rm -p 80:8000 -e SWAGGER_YAML_PATH=/spec/custom-api.yaml \
#     -v `pwd`/spec:/spec supinf/swagger-mock-api:1.6

FROM alpine:3.6

ENV MOCKAPI_VERSION=1.6.0 \
    SWAGGER_YAML_PATH=/api/swagger.yaml \
    NODE_VERSION=7.10.1-r0

WORKDIR /server

RUN apk --no-cache add tini nodejs-current=${NODE_VERSION}
RUN apk --no-cache add --virtual build-deps nodejs-current-npm=${NODE_VERSION} \

    # Install Grunt packages
    && npm install --global "grunt-cli@1.2.0" \
    && npm install "grunt@1.0.1" \
    && npm install "grunt-contrib-connect@1.0.2" \

    # Install dzdrazil/swagger-mock-api
    && npm install "swagger-mock-api@${MOCKAPI_VERSION}" \

    # Clean up
    && rm -rf /root/.npm \
    && apk del --purge -r build-deps \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

ADD Gruntfile.js /server/Gruntfile.js

# Add sample of API definitions
ADD petstore.yaml /api/swagger.yaml

ENTRYPOINT ["/sbin/tini", "--", "grunt"]
