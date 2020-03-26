FROM ruby:2.3-stretch  
LABEL maintainer="Marc Wickenden <marc@4armed.com>"  
  
RUN apt-get -yqq update \  
&& apt-get -yqq install build-essential \  
git-core \  
sqlite3 \  
libsqlite3-dev \  
nodejs \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /app  
RUN git clone https://github.com/beefproject/beef.git  
WORKDIR /app/beef  
RUN bundle install  
  
CMD ["./beef"]

