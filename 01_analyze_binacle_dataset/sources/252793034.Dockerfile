FROM python:alpine3.6  
RUN apk add --update gettext git nodejs nodejs-npm && \  
rm -rf /var/cache/apk/*  
  
WORKDIR /usr/src/app  
  
RUN git clone \--depth=1 git://github.com/danirus/django-comments-xtd.git && \  
cd django-comments-xtd && \  
python setup.py install && \  
npm install && \  
node_modules/webpack/bin/webpack.js -p && \  
cd django_comments_xtd && \  
django-admin compilemessages -l es && \  
django-admin compilemessages -l fi && \  
django-admin compilemessages -l fr && \  
cd ../example/comp && \  
pip install -r requirements.txt && \  
python manage.py migrate && \  
python manage.py loaddata ../fixtures/auth.json && \  
python manage.py loaddata ../fixtures/sites.json && \  
python manage.py loaddata ../fixtures/articles.json && \  
python manage.py loaddata ../fixtures/quotes.json  
  
EXPOSE 8000  
WORKDIR /usr/src/app/django-comments-xtd/example/comp  
  
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]  

