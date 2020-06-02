FROM ruby:2.1  
MAINTAINER rkj@difi.no  
  
RUN apt-get update \  
&& apt-get install -y \  
node \  
python-pygments \  
git \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/  
  
RUN gem install jekyll -v 2.5.3  
  
RUN gem install \  
kramdown \  
RedCloth \  
rdiscount \  
git \  
rouge  
  
VOLUME /src  
EXPOSE 4000  
WORKDIR /src  
ENTRYPOINT ["jekyll"]

