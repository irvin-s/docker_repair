from python:2.7  
ADD app.py /usr/src/app/app.py  
ADD resource_manager.py /usr/src/app/resource_manager.py  
ADD bbox_fua_sub.csv /usr/src/app/bbox_fua_sub.csv  
ADD bbxtest.csv /usr/src/app/bbxtest.csv  
ADD requirements.txt /usr/src/app/requirements.txt  
RUN pip install -r /usr/src/app/requirements.txt  

