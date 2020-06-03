FROM ruby:2.2.0  
RUN apt-get update && apt-get install -y npm && apt-get clean  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
RUN echo "gem: --no-document" > .gemrc  
RUN gem install rails -v 4.2.0  
RUN gem install puma -v 2.11.3  
RUN gem install mongoid -v 4.0.2  
RUN gem install slop -v 3.6.0  
RUN gem install byebug -v 3.5.1  
RUN gem install json -v 1.8.2  
RUN gem install doorkeeper -v 2.1.0  
RUN gem install faraday -v 0.9.1  
RUN gem install sass -v 3.4.14  
RUN gem install sass-rails -v 5.0.3  
RUN gem install minitest -v 5.6.1  
RUN gem install mime-types -v 2.5  
RUN gem install ansi -v 1.5.0  
RUN gem install bcrypt -v 3.1.10  
RUN gem install guard-livereload -v 2.4.0  
RUN gem install mocha -v 1.1.0  
RUN gem install mongoid -v 4.0.1  
RUN gem install oauth2 -v 1.0.0  
RUN gem install webmock -v 1.20.4  
RUN gem install ci_reporter_minitest -v 1.0.0  
RUN gem install turbolinks -v 2.5.3  
RUN gem install spring -v 1.3.4

