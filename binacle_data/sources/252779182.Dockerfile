FROM elasticsearch  
  
MAINTAINER Daniel Cerecedo <daniel.cerecedo@byteflair.com>  
  
RUN plugin install license \  
&& plugin install marvel-agent  
  

