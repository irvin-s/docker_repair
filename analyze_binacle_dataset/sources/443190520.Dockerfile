#########################
# multi stage Dockerfile
# 1. set up the build environment and build the expath-package
# 2. run the eXist-db
#########################
FROM openjdk:8-jdk as builder
LABEL maintainer="Peter Stadler"

ENV SMUFL_BUILD_HOME="/opt/smufl-build"

ARG XMLSH_URL="http://xmlsh-org-downloads.s3-website-us-east-1.amazonaws.com/archives%2Frelease-1_3_1%2Fxmlsh_1_3_1.zip"
ARG IMAGE_SERVER="https://smufl-browser.edirom.de/"

ADD ${XMLSH_URL} /tmp/xmlsh.zip
ADD https://deb.nodesource.com/setup_8.x /tmp/nodejs_setup 

WORKDIR ${SMUFL_BUILD_HOME}

RUN apt-get update \
    && apt-get install -y --force-yes ant git libsaxonhe-java \
    # installing nodejs
    && chmod 755 /tmp/nodejs_setup; sync \
    && /tmp/nodejs_setup \
    && apt-get install -y nodejs \
    # installing XMLShell
    && unzip /tmp/xmlsh.zip -d ${SMUFL_BUILD_HOME}/ \
    && mv ${SMUFL_BUILD_HOME}/xmlsh* ${SMUFL_BUILD_HOME}/xmlsh \
    && chmod 755 /opt/smufl-build/xmlsh/unix/xmlsh \
    && npm install -g yarn \
    && ln -s /usr/bin/nodejs /usr/local/bin/node

COPY . .

RUN addgroup smuflbuilder \
    && adduser smuflbuilder --ingroup smuflbuilder --disabled-password --system \
    && chown -R smuflbuilder:smuflbuilder ${SMUFL_BUILD_HOME}

USER smuflbuilder:smuflbuilder

RUN ant -lib /usr/share/java -Dimage.server=${IMAGE_SERVER} rebuild

#########################
# Now running the eXist-db
# and adding our freshly built xar-package
#########################
FROM stadlerpeter/existdb:4.5

# add SMuFL-browser specific settings 
# for a production ready environment with 
# SMuFL-browser as the root app.
# For more details about the options see  
# https://github.com/peterstadler/existdb-docker
ENV EXIST_ENV="production"
ENV EXIST_CONTEXT_PATH="/"
ENV EXIST_DEFAULT_APP_PATH="xmldb:exist:///db/apps/smufl-browser"

# simply copy our SMuFL-browser xar package
# to the eXist-db autodeploy folder
COPY --from=builder /opt/smufl-build/build/*.xar ${EXIST_HOME}/autodeploy/
