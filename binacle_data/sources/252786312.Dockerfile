FROM ruby:2.4  
RUN useradd --create-home app \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends \  
jq \  
graphviz  
WORKDIR /home/app  
COPY Gemfile* ./  
RUN bundle install --path vendor/bundle  
RUN curl -sL \  
https://api.github.com/repos/WardCunningham/image-transporter/tarball/master \  
| tar zx --strip-components=1 \  
&& mkdir public \  
&& chown -R app:app .  
USER app  
CMD ["bundle", "exec", "ruby", "server.rb"]  
  
EXPOSE 4010  

