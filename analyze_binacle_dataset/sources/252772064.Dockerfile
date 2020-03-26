FROM sstarcher/statsite  
  
RUN apt-get update && apt-get install -y python-pip python-dev build-essential  
  
RUN pip install riak  
  
ADD riak-ts.py /  
ADD statsite.conf.tmpl /conf  
  
ENV STREAM_CMD="python /riak-ts.py"  

