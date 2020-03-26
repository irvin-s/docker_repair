FROM python:3.6.4  
RUN apt-get update &&\  
apt-get install binutils libproj-dev gdal-bin libgeoip1 python3-gdal -y &&\  
apt-get autoremove -y &&\  
rm -rf /var/lib/apt/lists/* &&\  
rm -rf /var/cache/apt/*  
RUN pip install certifi pipenv && pipenv --update  
COPY ["Pipfile", "Pipfile.lock", "/app/"]  
WORKDIR /app  
RUN pipenv install  
  
COPY ["api", "/app/api"]  
COPY ["basestyle", "/app/basestyle"]  
COPY ["censusdata", "/app/censusdata"]  
COPY ["frontend", "/app/frontend"]  
COPY ["geo", "/app/geo"]  
COPY ["hmda", "/app/hmda"]  
COPY ["mapping", "/app/mapping"]  
COPY ["mapusaurus", "/app/mapusaurus"]  
COPY ["respondents", "/app/respondents"]  
COPY [".docker", "/app/.docker"]  
COPY ["manage.py", "/app/"]  
  
RUN pipenv run python manage.py collectstatic --noinput -c  
  
ENV ALLOWED_HOSTS="[\"localhost\", \"0.0.0.0\", \"127.0.0.1\"]"\  
PORT=8000  
CMD pipenv run .docker/start_server.sh  

