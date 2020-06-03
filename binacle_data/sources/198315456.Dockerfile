FROM maven:3.5.0-jdk-8

MAINTAINER citrusframework.org <citrus-dev-l@consol.de>

ENV APP_VERSION=1.0.3
ENV APP_ARTIFACT=citrus-admin-web
ENV DEPLOY_DIR /app
ENV APP_DIR /maven

ENV CITRUS_ADMIN_ROOT_DIRECTORY ${APP_DIR}

EXPOSE 8080

RUN mkdir ${DEPLOY_DIR}
RUN mkdir ${APP_DIR}

RUN curl https://labs.consol.de/maven/repository/com/consol/citrus/${APP_ARTIFACT}/${APP_VERSION}/${APP_ARTIFACT}-${APP_VERSION}-executable.war -o ${DEPLOY_DIR}/${APP_ARTIFACT}.war

RUN find $DEPLOY_DIR -name '*.war' -exec chmod a+x {} +

WORKDIR ${APP_DIR}

CMD java -jar ${DEPLOY_DIR}/${APP_ARTIFACT}.war