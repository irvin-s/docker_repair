FROM nimlang/nim:0.15.0-alpine

RUN apk add --no-cache clang
RUN apk add --no-cache pcre-dev
RUN apk add --no-cache mercurial

RUN nimble -y install docopt
RUN nimble -y install psutil
RUN nimble -y install strfmt

RUN clang --version
RUN nim --version

WORKDIR /src
