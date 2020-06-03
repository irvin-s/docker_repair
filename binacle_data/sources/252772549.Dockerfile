FROM awilson/ruby22  
MAINTAINER Ash Wilson  
  
RUN mkdir -p /opt/cloudpassage/wlslib/lib  
COPY ./lib/wlslib.rb /opt/cloudpassage/wlslib/lib/  
COPY ./wlslib.gemspec /opt/cloudpassage/wlslib/  
WORKDIR /opt/cloudpassage/wlslib  
RUN ["/root/.rbenv/shims/gem", "build", "wlslib.gemspec"]  
RUN ["/root/.rbenv/shims/gem", "install", "wlslib"]  

