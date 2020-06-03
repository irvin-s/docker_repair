FROM anowell/servur  
  
RUN apt-get update && \  
apt-get install -y software-properties-common && \  
apt-add-repository ppa:brightbox/ruby-ng && \  
apt-get update && \  
apt-get install -y ruby2.2 && \  
rm -rf /var/lib/apt/lists/*  
  
# Let executors manage deps with bundler  
RUN gem install bundler --no-rdoc  
ADD pre-init.d /etc/pre-init.d  
ENV GEM_PATH /home/arunner/vendor/bundle/ruby/2.2.0  
COPY arunner.rb /bin/arunner.rb  
  
WORKDIR /home/arunner  
USER arunner  
CMD ["/bin/arunner.rb"]  

