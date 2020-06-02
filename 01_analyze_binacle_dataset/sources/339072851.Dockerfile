FROM ruby:2.5

WORKDIR /ghpages

RUN apt-get install -y git

ADD . /ghpages/

WORKDIR /ghpages/docs/

RUN bundle install 

RUN git init && git remote add origin https://github.com/fga-gpp-mds/2018.1-TropicalHazards-BI.git

CMD bundle exec jekyll serve
