FROM python:3.6  
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \  
dpkg-reconfigure -f noninteractive tzdata  
  
WORKDIR /app  
EXPOSE 8000  
VOLUME /app/staticfiles  
  
RUN pip3 install pipenv  
COPY Pipfile Pipfile.lock ./  
RUN pipenv install  
  
COPY . ./  
  
RUN chmod +x bash/run-prod.sh  
CMD bash/run-prod.sh  
  
ENV DATABASE_URL postgres://postgresql:postgresql@db:5432/workout  
ENV SECRET_KEY ''  
ENV MAILGUN_ACCESS_KEY ''  
ENV MAILGUN_SERVER_NAME ''  
ENV DJANGO_ENV ''  
ENV ADMIN_EMAIL ''  
ENV SERVER_EMAIL ''  

