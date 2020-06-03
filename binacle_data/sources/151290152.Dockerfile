# https://code.google.com/p/end-to-end/wiki/BuildInstructions?tm=6

FROM silarsis/base
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

RUN apt-get install -yq git vim less subversion curl
VOLUME /opt/e2e_dev
WORKDIR /opt/e2e_dev
# Code
RUN git clone https://code.google.com/p/end-to-end/
# Closure Library
RUN git clone https://github.com/google/closure-library/
# Closure Templates
RUN svn checkout https://closure-templates.googlecode.com/svn/trunk/ closure-templates
# zlib.js
RUN git clone https://github.com/imaya/zlib.js && mkdir typedarray && ln -s ../zlib.js/define/typedarray/use.js typedarray/use.js
# JS Compiler
RUN curl https://dl.google.com/closure-compiler/compiler-latest.zip -O && unzip compiler-latest.zip
# CSS Compiler
RUN curl https://closure-stylesheets.googlecode.com/files/closure-stylesheets-20111230.jar -O
