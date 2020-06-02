FROM upfluence/sensu-server:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY slack.rb /sensu/slack.rb
COPY handlers.json /etc/sensu/conf.d/handlers.json
