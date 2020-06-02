#============================
# Checkout components library
#----------------------------
FROM alpine/git as components-source
ARG GIT_TAG=7.1.1
ARG GIT_REPO=https://github.com/angular/material2.git

WORKDIR /_tmp
RUN git clone --no-checkout --depth=1 -b ${GIT_TAG} ${GIT_REPO} . && \
    git fetch origin && \
    git checkout tags/${GIT_TAG}



#============================
# Install dependencies
#----------------------------
FROM node:10-alpine as components-library
# folders
ARG FOLDER=/components-library

# copy and install the components library
WORKDIR ${FOLDER}

# clean up all ressources
RUN rm -rf /components-library/*

COPY --from=components-source /_tmp ${FOLDER}

RUN yarn --ignore-scripts
