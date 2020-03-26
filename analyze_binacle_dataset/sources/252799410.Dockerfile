FROM django:onbuild  
MAINTAINER dennis@dhedegaard.dk  
EXPOSE 8000  
CMD python manage.py migrate && python manage.py runserver 0.0.0.0:8000  

