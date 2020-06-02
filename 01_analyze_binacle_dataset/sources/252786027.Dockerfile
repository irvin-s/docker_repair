FROM kaggle/python  
MAINTAINER Dominic Kwok <dominictskwok@gmail.com>  
  
RUN pip install musixmatch  
RUN pip install bs4  
RUN pip install wbdata  
RUN pip install --upgrade google-api-python-client  

