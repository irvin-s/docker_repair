FROM python:3.6-slim  
  
# Supporting libraries for python modules  
RUN apt-get update && apt-get install --yes \  
libpq-dev libjpeg-dev zlib1g-dev libpng12-dev libmagickwand-dev \  
python3-dev build-essential libjpeg-progs optipng  
  
# Debug tools  
RUN pip3 install --upgrade pip ipdb flake8 python-swiftclient psycopg2 pymongo  
  
# Add binaries to image  
ADD wait-for-postgres /wait-for-postgres  
ADD wait-for-mongo /wait-for-mongo  
  

