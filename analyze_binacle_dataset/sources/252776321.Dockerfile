# bongikairu/doodbot  
FROM python:3.5  
MAINTAINER bongikairu@gmail.com  
RUN export PYTHONUNBUFFERED=1  
RUN apt-get update && apt-get install libicu52 libicu-dev -y  
WORKDIR /  
RUN pip install honcho  
COPY requirements.txt /  
RUN pip install -r requirements.txt  
COPY doodbot/printer.py /usr/local/lib/python2.7/site-packages/honcho/  
COPY . /  
RUN python manage.py collectstatic --no-input  
EXPOSE 5000  
CMD bash -c "honcho start web 2>&1"

