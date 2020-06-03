FROM ruby:2.1
MAINTAINER Carl Boettiger cboettig@ropensci.org

RUN apt-get update \
  && apt-get install -y \
    git \
    node \
    python-pygments

# copy the whole roweb repo onto the container
COPY . /src

WORKDIR /src
RUN bundle install

EXPOSE 4000

CMD jekyll serve -H 0.0.0.0

