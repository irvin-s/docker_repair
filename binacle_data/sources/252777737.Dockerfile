FROM litaio/ruby  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get -y update  
RUN apt-get -y install git  
RUN apt-get -y install libxml2-dev libxslt-dev  
RUN apt-get -y install libcurl4-openssl-dev libpq-dev  
RUN apt-get -y install libsqlite3-dev build-essential  
  
RUN gem install bundler --no-ri --no-rdoc  
RUN gem install foreman --no-ri --no-rdoc  
RUN gem install clockwork -v 1.0.0 --no-ri --no-rdoc  
  
RUN git clone git://github.com/swanson/stringer.git /stringer  
  
ENV RACK_ENV "production"  
ENV STRINGER_DATABASE "stringerdb"  
WORKDIR /stringer  
  
RUN sed -i 's/^ruby "2.0.0"/ruby "2.1.2"/' Gemfile  
RUN sed -i 's/^console/#console/' Procfile  
  
RUN echo "clock: clockwork clock.rb" >> Procfile  
  
RUN bundle install  
  
EXPOSE 5000  
ADD ./clock.rb /stringer/clock.rb  
ADD ./run.sh /stringer/run.sh  
CMD bash /stringer/run.sh  

