FROM python  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /labs  
WORKDIR /labs  
  
RUN set -x \  
&& apt-get update \  
&& apt-get install -y zsh nano git  
  
# ADD . /labs  
ADD requirements /labs/requirements  
RUN pip install -r requirements/labs.txt  

