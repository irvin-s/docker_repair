FROM heroku/python  
  
ONBUILD RUN pip install -U pip  
ONBUILD RUN pip install --upgrade virtualenv  
ONBUILD RUN virtualenv --no-site-packages /venv/  
ONBUILD ADD requirements.txt /venv/  
ONBUILD RUN /venv/bin/pip install -r /venv/requirements.txt  

