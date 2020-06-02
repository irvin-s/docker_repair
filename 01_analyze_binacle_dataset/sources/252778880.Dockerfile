FROM python:3.6.5-onbuild  
EXPOSE 80  
CMD ["uwsgi", "--ini", "uwsgi.ini:production"]  

