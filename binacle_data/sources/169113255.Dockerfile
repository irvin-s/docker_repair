FROM nacyot/ruby-ruby:2.1.2

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 libzmq3-dev python3 python3-pip libmagickwand-dev &&\
  pip3 install ipython==1.2.0 jinja2 tornado pyzmq &&\
  rm /usr/bin/python &&\ 
  ln -s /usr/bin/python3 /usr/bin/python &&\
  ln -s /usr/local/bin/ipython3 /usr/local/bin/ipython

RUN gem install pry pry-doc pry-theme pry-syntax-hacks pry-git awesome_print gruff rmagick gnuplot rubyvis iruby

RUN mkdir -p /root/.config/iruby/

VOLUME /root/notebooks
EXPOSE 8888
CMD /root/.rbenv/versions/2.1.2/bin/iruby notebook --ip=0.0.0.0 --notebook-dir=/root/notebooks
 
