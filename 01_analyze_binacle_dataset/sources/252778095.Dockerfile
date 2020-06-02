FROM tuyendv2/youtube-dl-onbuild  
RUN pip install --no-cache-dir -r requirements.txt  
  
RUN [ "python", "./youtube-dl.py" ]  

