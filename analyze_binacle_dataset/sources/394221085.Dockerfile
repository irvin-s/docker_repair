FROM ruby:2.4.1
ENV app /app
RUN mkdir $app
WORKDIR $app
ADD . $app
RUN bundle install
CMD ["./oncall.rb"]
