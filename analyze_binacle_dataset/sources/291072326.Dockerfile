FROM ubuntu

RUN apt-get update &&\
    apt-get install -y ruby-dev build-essential nodejs tzdata vim
RUN apt-get install -y libxslt-dev libxml2-dev zlib1g-dev
RUN gem install bundler

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo ":set encoding=utf8\n:set expandtab tabstop=4 softtabstop=4 shiftwidth=4" > ~/.vimrc

RUN mkdir -p /root/.ssh
ADD justcopy_id_rsa /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa

RUN apt-get install -y git openssh-server && \
    ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts

WORKDIR /jekyll
ADD Gemfile .
ADD Gemfile.lock .
RUN ln -s /usr/lib/libz.so.1.2.8 /usr/lib/libzlib.so && \
    apt-get install -y libblas-dev liblapack-dev libgsl0-dev
RUN bundle install

WORKDIR /jekyll/site
RUN git init && \
    git remote add origin git@github.com:ailabstw/news-ptt.git

WORKDIR /jekyll
ADD lib/related_posts.rb /var/lib/gems/2.3.0/gems/jekyll-3.4.5/lib/jekyll/related_posts.rb

# CMD sh copy.sh && bundle exec jekyll serve --host 0.0.0.0 --port 3999 
CMD ln -s /_posts _posts && bundle exec jekyll build -s . -d /site && sh script/publish.sh
