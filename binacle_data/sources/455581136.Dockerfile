FROM ruby:2.2

RUN gem install rt-tackle
RUN gem install activerecord
RUN gem install rake
RUN gem install pg

ADD publish /bin/publish
RUN chmod +x /bin/publish

ADD worker.rb worker.rb
ADD model.rb model.rb
ADD app.rb app.rb

CMD ruby app.rb
