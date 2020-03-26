FROM chuckus/python-2.7-pandas  
MAINTAINER Charlie Smith <charlie.smith@mapof.ag>  
  
RUN apt-get update && apt-get install -y libpq-dev postgresql && \  
pip install psycopg2==2.6.1 && \  
pip install Django==1.9.2 && \  
pip install djangorestframework==3.3.2 && \  
pip install psycopg2==2.6.1 && \  
pip install pycrypto==2.6.1 && \  
apt-get purge -y libpq-dev postgresql && \  
apt-get clean -y && \  
apt-get autoremove -y  
  
# RUN python -c "from Crypto.Cipher import AES"  
# RUN python -c "import psycopg2"  

