FROM moqod/django-backend  
ADD requirements /code/requirements  
RUN pip install -r requirements/dev.txt  

