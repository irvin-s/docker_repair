FROM ubuntu:latest  
RUN apt-get update  
RUN apt-get install -y python3  
RUN apt-get install -y python3-pip  
  
ADD ./requirements.txt /requirements.txt  
RUN pip3 install -r /requirements.txt  
RUN rm /requirements.txt  
  
COPY . /libraro  
  
EXPOSE 80  
WORKDIR /libraro  
  
RUN python3 manage.py makemigrations pages dictionary --noinput  
RUN python3 manage.py migrate  
RUN python3 manage.py loaddata initial_data  
RUN python3 manage.py generate_html  
RUN python3 manage.py collectstatic --noinput  
  
CMD gunicorn -b 0.0.0.0:80 libraro.wsgi:application  

