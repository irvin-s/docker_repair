FROM cscdock/hanlon  
  
MAINTAINER Joseph Callen <jcpowermac@gmail.com>  
  
WORKDIR /home/hanlon  
ENV TEST_MODE true  
RUN mkdir /home/hanlon/cli/log  
  
ENTRYPOINT ["/usr/local/bin/ruby", "/home/hanlon/cli/hanlon"]  
  
CMD ["--help"]  

