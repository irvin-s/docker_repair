FROM erlang  
  
ADD . /elsa  
WORKDIR /elsa  
  
RUN mv /elsa/config/sys.config.docker /elsa/config/sys.config  
  
RUN /elsa/rebar3 release  
  
ENTRYPOINT ["/elsa/_build/default/rel/elsa/bin/elsa"]  
  
EXPOSE 8080  
CMD ["foreground"]  

