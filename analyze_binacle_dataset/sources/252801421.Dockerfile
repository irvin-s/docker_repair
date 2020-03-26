FROM r-base:3.1.2  
MAINTAINER Eamon O'Dea <[last name without apostrophe]35@gmail.com>  
  
RUN install2.r --error \  
fields \  
ggplot2 \  
igraph \  
pander \  
vegan \  
&& rm -rf /tmp/download_packages/ /tmp/*.rds  
  
CMD ["bash"]  

