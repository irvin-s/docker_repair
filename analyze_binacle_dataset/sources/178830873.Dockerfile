FROM upfluence/sensu-base:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

RUN gem instal mixlib-cli json
RUN curl -sL \
  https://github.com/upfluence/sensu-plugin/releases/download/v1.2.1/sensu-plugin-1.2.1.gem \
  > /tmp/sensu-plugin.gem && gem install --local /tmp/sensu-plugin.gem

ADD run.sh /sensu/run.sh

CMD ./run.sh
