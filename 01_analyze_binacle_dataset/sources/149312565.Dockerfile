FROM ruby

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 LANGUAGE=C.UTF-8

WORKDIR /srv/app
COPY Gemfile* ./
RUN bundle install --jobs 4

COPY . .

CMD [ "/bin/bash" ]
