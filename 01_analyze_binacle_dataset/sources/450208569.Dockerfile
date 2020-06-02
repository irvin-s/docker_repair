FROM heroku/cedar:14
MAINTAINER Heroku Build & Packaging Team <build-and-packaging@heroku.com>
COPY . /app
WORKDIR /app
ENV HOME /app
ENV PATH $PATH:$HOME/bin
RUN mkdir -p /var/lib/buildpack /var/cache/buildpack
RUN curl https://codon-buildpacks.s3.amazonaws.com/buildpacks/heroku/go.tgz | tar xz -C /var/lib/buildpack 2>/dev/null
RUN /var/lib/buildpack/bin/compile /app /var/cache/buildpack
