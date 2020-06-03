# swagger-codegen v2.2
#
# docker run --rm supinf/swagger-codegen:2.2
# docker run --rm -v $(pwd)/spec:/spec supinf/swagger-codegen:2.2 \
#    validate -i /spec/swagger.yaml
# docker run --rm -it -v `pwd`:/src supinf/swagger-codegen:2.2 \
#    generate -i /src/swagger.yaml -o /src/generated -l javascript

FROM openjdk:8u131-jre-alpine

ENV SWAGGER_CODEGEN_VERSION=2.2.3

ADD swagger-codegen /usr/bin/
RUN chmod +x /usr/bin/swagger-codegen \
    && apk --no-cache add bash

RUN apk --no-cache add --virtual build-deps curl \
    && repo="http://central.maven.org/maven2/io/swagger/swagger-codegen-cli/${SWAGGER_CODEGEN_VERSION}" \
    && curl --location --silent --show-error --out /swagger-codegen-cli.jar \
        ${repo}/swagger-codegen-cli-${SWAGGER_CODEGEN_VERSION}.jar \
    && apk del --purge -r build-deps

ENTRYPOINT ["swagger-codegen"]
CMD ["help"]
