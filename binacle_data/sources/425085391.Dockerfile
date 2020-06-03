# RVM (gewo/rvm)
FROM gewo/interactive
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get -y install curl git && apt-get clean
# RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc
RUN \
  echo 'source /etc/profile.d/rvm.sh' >> /etc/shell_env &&\
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc &&\
  echo "export rvm_trust_rvmrcs_flag=1" >> ~/.rvmrc &&\
  echo "export rvm_autoupdate_flag=2" >> ~/.rvmrc

RUN \
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 &&\
  curl -L https://get.rvm.io | bash -s stable && rvm requirements

RUN echo 'bundler' >> /usr/local/rvm/gemsets/global.gems

CMD ["/bin/bash"]
