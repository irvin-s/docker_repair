FROM python:3.6  
LABEL app.name="Storified" \  
app.description="Archive Storify stories" \  
app.repo.url="https://github.com/DocNow/storified"  
  
WORKDIR /storified  
COPY * ./  
RUN python setup.py install  
  
ENTRYPOINT ["storified.py", "--download-dir", "downloads"]  

