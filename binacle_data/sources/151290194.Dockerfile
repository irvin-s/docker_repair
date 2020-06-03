FROM ubuntu:trusty
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade && apt-get -yq install curl
RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.0"
RUN /bin/bash -l -c "rvm install 2.1"
RUN /bin/bash -l -c "rvm install 2.1.1"
RUN /bin/bash -l -c "rvm @global do gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "rvm @global do gem install ZenTest --no-ri --no-rdoc"
RUN /bin/bash -l -c "rvm @global do gem install rspec-autotest --no-ri --no-rdoc"
