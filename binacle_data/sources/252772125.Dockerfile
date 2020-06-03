FROM python:3  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /code  
WORKDIR /code  
  
# ADD requirements.txt /code/  
# RUN pip install -r requirements.txt  
RUN git clone -b master https://github.com/RFS-0/ddpmfa.git ddpmfa_git  
RUN mv ddpmfa_git/ddpmfa/* .  
RUN cp ddpmfa_git/requirements.txt .  
RUN rm -rf ddpmfa_git  
  
RUN pip install -r requirements.txt  
  
ADD . /code/  
RUN python3 manage.py makemigrations  
RUN python3 manage.py migrate  
CMD python3 manage.py runserver 0.0.0.0:8000  
  

