FROM bowery/ruby  
ADD . /opt/code_driven_development_server  
WORKDIR /opt/code_driven_development_server  
RUN bundle install  
CMD rackup -p 3000  
EXPOSE 3000  

