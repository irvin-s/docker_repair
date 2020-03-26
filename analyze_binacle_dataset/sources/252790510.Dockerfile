FROM ubuntu:14.04  
MAINTAINER cariandrum22@gmail.com  
  
# Install packages for building ruby  
RUN apt-get update  
RUN apt-get install -y --force-yes build-essential curl git zlib1g-dev \  
libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev libffi-dev  
RUN apt-get clean  
  
# Create rails user  
# TODO # Get password from docker run aurg  
RUN useradd -m -s /bin/bash rails  
RUN echo 'rails:password' | chpasswd  
RUN echo 'rails ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/rails  
  
# Change rails user  
USER rails  
ENV HOME /home/rails  
  
# Install rbenv and ruby-build  
WORKDIR /home/rails  
RUN git clone https://github.com/sstephenson/rbenv.git /home/rails/.rbenv  
RUN git clone https://github.com/sstephenson/ruby-build.git\  
/home/rails/.rbenv/plugins/ruby-build  
ENV PATH ${HOME}/.rbenv/bin:${PATH}  
RUN echo 'export PATH=${HOME}/.rbenv/bin:${PATH}' >> ~/.bash_profile  
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile  
  
# Install multiple versions of ruby  
ENV CONFIGURE_OPTS --disable-install-doc  
ADD ./ruby-versions /home/rails/ruby-versions  
RUN xargs -L 1 rbenv install < /home/rails/ruby-versions  
  
# Install Bundler for each version of ruby  
RUN echo 'gem: --no-rdoc --no-ri' >> /home/rails/.gemrc  
RUN bash -l -c 'eval "$(rbenv init -)"; \  
for v in $(cat /home/rails/ruby-versions); \  
do rbenv global $v; gem install bundler; done'  
  
# Create application directory  
USER root  
RUN mkdir -p /var/app  
RUN chown rails:rails /var/app  

