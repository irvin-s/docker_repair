FROM ruby:latest  
  
# cross-compile-start  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
nodejs \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
arp-scan \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /usr/src/app  
COPY Gemfile* ./  
RUN bundle install  
COPY . .  
  
RUN bin/rake assets:precompile  
  
# cross-compile-end  
EXPOSE 3000  
CMD ["bin/rails", "s", "-b", "0.0.0.0"]  
  

