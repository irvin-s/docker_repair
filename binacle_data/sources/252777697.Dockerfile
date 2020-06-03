FROM ubuntu:latest  
LABEL maintainer="github.com/antoinehng"  
  
# Various dependencies  
RUN apt-get update -yqq && apt-get install -yqq \  
build-essential \  
git \  
python3 python3-setuptools python3-dev python3-tk python3-pip npm  
RUN npm install -g bower && ln -s /usr/bin/nodejs /usr/bin/node  
  
# Install FFmpeg dependencies  
RUN apt-get install -yqq ffmpeg  
  
# Clone pixelwalker repo  
RUN git clone https://github.com/antoinehng/pixelwalker.git /pixelwalker  
WORKDIR /pixelwalker  
RUN git checkout django_2.0 && git pull  
  
# Python dependencies  
RUN pip3 install -r requirements.txt  
  
# Bower JS+CSS dependencies  
RUN bower --allow-root install  
  
WORKDIR /pixelwalker/pixelwalker  
  
# Install pixelwalker  
RUN python3 manage.py migrate  
  
# Load fixtures  
RUN python3 manage.py loaddata AppSettings  
RUN python3 manage.py loaddata TaskTypes  
  
# Execute django test suite  
RUN python3 manage.py test  
  
# Expose web server port  
EXPOSE 8000  
# Start django dev server  
CMD python3 manage.py runserver 0.0.0.0:8000  

