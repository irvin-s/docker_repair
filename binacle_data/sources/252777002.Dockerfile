FROM python:3.6  
RUN mkdir Fall2017Swe573  
  
COPY ./ /Fall2017Swe573  
  
RUN pwd  
  
RUN ls  
  
WORKDIR /Fall2017Swe573  
RUN pip install -r requirements.txt  
  
EXPOSE 8000  
WORKDIR /Fall2017Swe573/swe573  
  
RUN python manage.py migrate  
  
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]  

