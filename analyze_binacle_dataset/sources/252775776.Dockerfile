FROM python:3.5  
MAINTAINER philipp.holler93@googlemail.com  
  
# Add python files  
ADD /requirements.txt /  
  
RUN pip install -r /requirements.txt \  
&& rm /requirements.txt  
  
ADD /magnet-premiumize-jd.py /  
RUN chmod +x /magnet-premiumize-jd.py  
  
CMD ["python", "/magnet-premiumize-jd.py"]

