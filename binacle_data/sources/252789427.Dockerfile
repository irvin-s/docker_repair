FROM phusion/baseimage  
MAINTAINER Dan Leehr <dan.leehr@duke.edu>  
  
# Install python  
RUN apt-get update && apt-get install -y \  
python  
  
ADD extract_go_terms.py /usr/bin/extract_go_terms.py  
ADD extract_go_terms-cli.py /usr/bin/extract_go_terms-cli.py  
  
CMD ["/usr/bin/extract_go_terms.py"]  

