FROM centurylink/ruby-base:2.1.2  
ADD . /usr/local/src/pmx-runner  
WORKDIR /usr/local/src/pmx-runner  
RUN chmod +x pmx_runner.rb  
RUN bundle  
  
CMD [""]  
ENTRYPOINT ["./pmx_runner.rb"]  

