FROM python:3.5  
MAINTAINER philipp.holler93@googlemail.com  
  
# Add python files  
ADD /requirements.txt /  
  
RUN pip install -r /requirements.txt \  
&& rm /requirements.txt  
  
ADD /magnet-alldebrid-jd.py /  
RUN chmod +x /magnet-alldebrid-jd.py  
  
CMD ["python", "/magnet-alldebrid-jd.py"]

