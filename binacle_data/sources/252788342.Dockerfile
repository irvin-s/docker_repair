FROM python:3-alpine  
  
RUN apk add --no-cache tzdata && \  
cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && \  
echo "Europe/Paris" > /etc/timezone  
  
RUN apk add --no-cache postgresql-dev gcc musl-dev  
  
WORKDIR /app  
EXPOSE 8000  
VOLUME /app/staticfiles  
  
RUN pip3 install pipenv  
COPY Pipfile Pipfile.lock ./  
RUN pipenv install  
  
COPY . ./  
  
RUN chmod +x bash/run-prod.sh  
CMD bash/run-prod.sh  
  
ENV DATABASE_URL postgres://postgresql:postgresql@db:5432/refunds  
ENV SECRET_KEY ''  
ENV MAILGUN_ACCESS_KEY ''  
ENV MAILGUN_SERVER_NAME ''  
ENV DJANGO_ENV ''  
ENV ADMIN_EMAIL ''  
ENV SERVER_EMAIL ''  

