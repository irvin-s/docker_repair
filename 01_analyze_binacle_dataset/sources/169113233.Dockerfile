FROM nacyot/clojure-clojure:1.6.0

RUN \
  apt-get update &&\
  apt-get install -y libzmq3 python python-pip python-zmq python-jinja2 python-tornado python &&\
  pip install ipython==1.1.0

# Install Lein
ENV LEIN_ROOT true
RUN \
  wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein &&\
  chmod a+x /usr/local/bin/lein

# Install ipython-clojure
RUN \
  git clone https://github.com/roryk/ipython-clojure.git /root/ipython-clojure &&\
  cd /root/ipython-clojure &&\
  sed -i -e 's/jeromq "0.3.3"/jeromq "0.3.2"/g' ./project.clj &&\
  make &&\
  ln -s /root/ipython-clojure/bin/ipython-clojure /usr/local/bin/ipython-clojure

RUN ipython profile create clojure
ADD ./ipython_config.py /root/.ipython/profile_clojure/ipython_config.py

VOLUME /root/notebooks
EXPOSE 8888
CMD ipython notebook --profile=clojure --ip=0.0.0.0 --notebook-dir=/root/notebooks
