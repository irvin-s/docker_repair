FROM ruby:2.1  
MAINTAINER jason@thesparktree.com  
  
RUN apt-get update \  
&& apt-get install -y \  
node \  
python-pygments \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/  
  
RUN gem install \  
github-pages \  
jekyll \  
jekyll-redirect-from \  
kramdown \  
rdiscount \  
rouge  
  
VOLUME /src  
EXPOSE 4000  
WORKDIR /src  
  

