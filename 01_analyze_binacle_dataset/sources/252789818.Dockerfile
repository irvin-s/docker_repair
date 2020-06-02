FROM python:3.6  
  
RUN mkdir /app  
WORKDIR /app  
  
RUN apt-get update  
  
RUN apt-get install -y --no-install-recommends \  
postgresql-client  
  
RUN pip install Django==1.11.4 \  
django-jet==1.0.6 \  
pytz==2017.2 \  
python-dotenv==0.6.5 \  
psycopg2==2.7.3 \  
djangorestframework==3.6.3 \  
django-filter==1.0.4 \  
Markdown==2.6.9 \  
coreapi==2.3.1 \  
Pygments==2.2.0 \  
django-crispy-forms==1.6.1 \  
django-webpack-loader==0.5.0 \  
djangorestframework-jwt==1.11.0 \  
flake8==3.4.1  

