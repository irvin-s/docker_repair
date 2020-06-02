FROM alpine  
  
RUN apk update  
  
RUN apk add --no-cache tzdata && \  
cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && \  
echo "Europe/Paris" > /etc/timezone  
  
RUN apk add --no-cache python3 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
rm -r /root/.cache  
  
RUN apk add --no-cache python3-dev postgresql-dev gcc musl-dev  
  
RUN apk add --no-cache openssl ca-certificates  
  
WORKDIR /app  
  
COPY requirements.txt /app  
  
RUN pip3 install -r requirements.txt  
  
COPY . /app  
  
VOLUME /app/staticfiles  
  
ENV DATABASE_URL postgres://postgresql:postgresql@db:5432/dashboard  
  
EXPOSE 8000  
RUN chmod +x bash/run-prod.sh  
  
CMD /app/bash/run-prod.sh  
  
# RUN python manage.py compilemessages -l en -l fr  

