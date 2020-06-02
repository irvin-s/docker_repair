FROM ruby:2.4.4
COPY . /crmds
COPY ./conf/app.json.docker /crmds/conf/app.json
WORKDIR /crmds

RUN bundle install

EXPOSE 3000
