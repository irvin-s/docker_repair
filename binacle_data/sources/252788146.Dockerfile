FROM creativelogic/php704cli_python  
  
MAINTAINER Deon van der Vyver <deon@creativelogic.es>  
  
# Install python & scrapy  
# https://scrapy.org  
RUN pip install --upgrade pip \  
&& pip install --upgrade virtualenv \  
&& pip install scrapy dateparser requests retrying scrapy-crawlera  

