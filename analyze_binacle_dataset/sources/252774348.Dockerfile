FROM python:3.5  
# Create users and groups  
RUN groupadd -g 1000 app  
  
RUN useradd -ms /bin/bash -G app run  
  
# set up directories  
ENV APP_HOME /home/run  
RUN mkdir -p $APP_HOME  
WORKDIR $APP_HOME  
  
# Install pip dependencies  
RUN pip install numpy  
RUN pip install ephem  
RUN pip install sgp4  
RUN pip install python-dateutil  
RUN pip install represent  
RUN pip install astropy  
RUN pip install matplotlib  
RUN pip install spacetrack  
RUN pip install scipy  
RUN pip install scikit-learn  
RUN pip install poliastro  
  
# Switch to run user, so we don't mess up permissions  
USER run  
ADD . .  
  
CMD python test.py  

