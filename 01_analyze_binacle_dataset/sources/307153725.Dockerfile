FROM docker

ARG SVN_USER
ARG SVN_PASSWORD 

ARG PROJECT_VERSION=trunk

RUN apk add --no-cache subversion

WORKDIR /project

RUN svn export --username $SVN_USER --password $SVN_PASSWORD --no-auth-cache http://subversion.domain.tld/project/${PROJECT_VERSION} src 
ADD Dockerfile.release Dockerfile

CMD docker build --no-cache --rm --force-rm -t project . 
