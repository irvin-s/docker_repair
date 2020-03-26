FROM ruby

RUN gem install rest_shifter -v 0.0.28
ENTRYPOINT ["rest_shifter"]
