FROM combient/docker-ds-toolbox:latest  
  
RUN python -m nltk.downloader -d /usr/local/share/nltk_data all  
  

