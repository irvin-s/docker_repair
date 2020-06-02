FROM registry.theopencloset.net/opencloset/node:latest as builder
MAINTAINER Hyungsuk Hong <aanoaa@gmail.com>

WORKDIR /build

# npm -> bower -> grunt 순서대로
COPY package.json package.json
RUN npm install

COPY .bowerrc .bowerrc
COPY bower.json bower.json
RUN bower --allow-root install

COPY coffee/ coffee/
COPY public/jst/ public/jst/
COPY less/ less/
COPY pdfmake/ pdfmake/
COPY Gruntfile.coffee Gruntfile.coffee
RUN grunt


# https://docs.docker.com/engine/userguide/eng-image/multistage-build/
FROM registry.theopencloset.net/opencloset/perl:latest

RUN groupadd opencloset && useradd -g opencloset opencloset

WORKDIR /tmp
COPY cpanfile cpanfile
RUN cpanm --notest \
    --mirror http://www.cpan.org \
    --mirror http://cpan.theopencloset.net \
    --installdeps .

# Everything up to cached.
WORKDIR /home/opencloset/service/staff.theopencloset.net
COPY --from=builder /build .
COPY . .
RUN chown -R opencloset:opencloset .
RUN mv app.conf.sample app.conf

USER opencloset
ENV MOJO_HOME=/home/opencloset/service/staff.theopencloset.net
ENV MOJO_CONFIG=app.conf

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["hypnotoad"]

EXPOSE 5000
