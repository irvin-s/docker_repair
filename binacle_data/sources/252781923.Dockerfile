FROM ruby:2.5-alpine  
RUN echo 'gem: --no-document' > ~/.gemrc \  
&& gem update --system \  
&& gem update bundler \  
&& gem cleanup all  
WORKDIR /app  
ADD . /app  
RUN bundle install --clean --jobs=4  
RUN mkdir data  
ENV RUBYGEMS_PROXY=true REMOTE_FAILURE=true  
EXPOSE 9292  
ENTRYPOINT /app/start.sh  

