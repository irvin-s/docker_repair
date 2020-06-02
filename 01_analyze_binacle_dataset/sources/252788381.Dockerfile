FROM crosbymichael/python  
  
RUN pip install --upgrade youtube_dl && mkdir /download  
WORKDIR /download  
ENTRYPOINT ["youtube-dl"]  
CMD ["--help"]  

