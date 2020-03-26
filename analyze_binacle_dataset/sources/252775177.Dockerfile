FROM ruby:2.3  
MAINTAINER Jay Scott <jay@beardyjay.co.uk>  
  
RUN apt-get update && apt-get -y install \  
gnuplot \  
lame \  
build-essential \  
libssl-dev \  
libcurl4-openssl-dev \  
postgresql-contrib \  
git-core \  
curl \  
libpq-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /home/warvox  
RUN git clone https://github.com/rapid7/warvox /home/warvox \  
&& ln -s /usr/bin/ruby2.1 /usr/bin/ruby \  
&& bundle install \  
&& make  
  
ADD setup.sh /  
EXPOSE 7777  
CMD ["/setup.sh"]  

