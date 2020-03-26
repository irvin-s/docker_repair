FROM python:3.6-alpine  
  
ENV FLASK_APP dec  
  
# Install application dependencies  
COPY requirements.txt .  
RUN pip install -r requirements.txt  
  
# Install test dependencies  
RUN pip install \  
flake8 \  
flake8_docstrings \  
pytest-flask  
  
RUN mkdir -p /opt/app  
WORKDIR /opt/app  
  
COPY . .  
  
EXPOSE 5000  
CMD ["flask", "run", "--host=0.0.0.0"]  

