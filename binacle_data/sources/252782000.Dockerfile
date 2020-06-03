FROM python:3-onbuild  
ADD "src" "/metis"  
WORKDIR "/metis"  
EXPOSE 8000  
CMD [ "python", "manage.py", "runserver", "--insecure", "0.0.0.0:8000"]  

