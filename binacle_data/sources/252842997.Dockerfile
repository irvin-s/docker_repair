FROM ubuntu:16.04

# basics
RUN apt-get update && \
    apt-get install -y software-properties-common openssl firefox xvfb curl wget xmlstarlet unzip netcat && \
    apt-add-repository -y ppa:rael-gc/rvm && \
    apt-get update && \
    apt-get install -y rvm

ENV  RUBY_VERSION 2.4.1
RUN  /bin/bash -l -c "rvm install $RUBY_VERSION" && \
     /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN  apt-get install -y default-jre

ENV   GECKODRIVER_VERSION v0.19.1
RUN   mkdir -p /opt/geckodriver_folder && \
      wget -O /tmp/geckodriver_linux64.tar.gz https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
      tar xf /tmp/geckodriver_linux64.tar.gz -C /opt/geckodriver_folder && \
      rm /tmp/geckodriver_linux64.tar.gz && \
      chmod +x /opt/geckodriver_folder/geckodriver && \
      ln -fs /opt/geckodriver_folder/geckodriver /usr/local/bin/geckodriver

#Configuring the tests to run in the container
RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN /bin/bash -l -c "gem update" && \
    /bin/bash -l -c "bundle install"

RUN curl -s https://raw.githubusercontent.com/zaproxy/zap-admin/master/ZapVersions.xml | xmlstarlet sel -t -v //url | grep -i Linux | wget --content-disposition -i - -O - | tar zxv

ADD features /app/features
ADD build /app/build
ADD cucumber-command-parallel.sh /app/cucumber-command-parallel.sh

RUN chmod a+x /app/cucumber-command-parallel.sh

CMD   cd ZAP* && \
      /bin/bash -l -c "./zap.sh -daemon -host $zap_proxy -port $zap_port -config api.disablekey=true &" && \
      cd .. && \
      while ! nc -z $zap_proxy $zap_port ; do sleep 1; done && \
      /bin/bash -l -c 'xvfb-run --server-args="-screen 0 1440x900x24" bash cucumber-command-parallel.sh'