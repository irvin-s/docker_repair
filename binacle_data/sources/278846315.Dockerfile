FROM maven AS builder

ENV WASABI_OSX macOS
ENV WASABI_OS linux

#Iinstall Nodejs
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - &&\
    apt-get update && apt-get install -y --no-install-recommends nodejs &&\
    npm install -g bower &&\
    npm install -g grunt-cli &&\
    npm install -g yo 

RUN apt-get update && apt-get install -y git-flow ruby ruby-compass

RUN git clone https://github.com/intuit/wasabi.git
WORKDIR wasabi
RUN mvn versions:set -DnewVersion=latest
RUN ./bin/build.sh -b true -t false -p development

##########################################

FROM openjdk

ENV WASABI_MODULE wasabi-main
ENV WASABI_UI_MODULE wasabi-ui-main
ENV UI_HOST '0.0.0.0'
ENV WASABI_PORT 8080
ENV WASABI_JMX_PORT 8090
ENV WASABI_DEBUG_PORT 8180
ENV WASABI_UI_PORT 9000
ENV WASABI_UI_TEST_PORT 9001
ENV WASABI_UI_LIVERELOAD_PORT 35729

ENV WASABI_SRC_DIR wasabi-main-latest-development
ENV WASABI_HOME /usr/local/${WASABI_SRC_DIR}

# install Nodejs
RUN wget -qO- https://deb.nodesource.com/setup_6.x | bash - &&\
    apt-get update && apt-get install -y --no-install-recommends nodejs &&\
    npm install -g bower &&\
    npm install -g grunt-cli &&\
    npm install -g yo 

RUN apt-get update && apt-get install -y --no-install-recommends ruby ruby-compass

COPY --from=builder /wasabi/modules/main/target/${WASABI_SRC_DIR}/ ${WASABI_HOME}/
COPY  ./wasabi-entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod 755 ${WASABI_HOME}/bin/run
RUN chmod 755 /usr/local/bin/entrypoint.sh
RUN sed -i -e $'s/1>>.*2>&1//' ${WASABI_HOME}/bin/run 2>/dev/null;

# build ui module
COPY --from=builder /wasabi/modules/ui/ /usr/local/wasabi-ui/
WORKDIR /usr/local/wasabi-ui/
RUN npm install && bower install --allow-root && grunt build

EXPOSE ${WASABI_PORT}
EXPOSE ${WASABI_JMX_PORT}
EXPOSE ${WASABI_DEBUG_PORT}
EXPOSE ${WASABI_UI_TEST_PORT}
EXPOSE ${WASABI_UI_LIVERELOAD_PORT}

ENTRYPOINT ["entrypoint.sh"]