FROM alpine:latest  
MAINTAINER Chris Ortner <chris@codexfons.com>  
  
ENV GUNICORN_PORT=8000  
ENV GUNICORN_MODULE=server  
ENV GUNICORN_CALLABLE=app  
ENV GUNICORN_USER=gunicorn  
ENV APP_PATH=/opt/app  
  
# Install dependencies and create runtime user.  
RUN apk add \--no-cache python3 \  
&& python3 -m ensurepip \  
&& pip3 install --upgrade pip gunicorn \  
&& adduser -D -h $APP_PATH $GUNICORN_USER  
# Copy the application over into the container.  
ADD . $APP_PATH  
# Install the application's dependencies.  
RUN pip3 install -r $APP_PATH/requirements.txt  
  
USER $GUNICORN_USER  
WORKDIR $APP_PATH  
ENTRYPOINT $APP_PATH/entrypoint.sh  

