FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y --fix-missing build-essential 
RUN apt-get install -y --fix-missing gcc 
RUN apt-get install -y --fix-missing python-dev 
RUN apt-get install -y --fix-missing python-pip 
RUN apt-get install -y --fix-missing libmysqlclient-dev 
RUN apt-get install -y --fix-missing git  
RUN apt-get install -y --fix-missing wget 
RUN apt-get install -y --fix-missing unzip 
RUN apt-get install -y --fix-missing firefox
RUN apt-get install -y --fix-missing xvfb 
RUN apt-get install -y --fix-missing tar
#libglib2.0-0 libxi6 libgconf-2-4 ibglib2.0-0 libxss1 libgconf-2-4 libnss3 libfontconfig libX11.6 


WORKDIR /app

ENV PATH="/app:${PATH}"

# move above pip
COPY unsubscribe/geckodriver.sh /app/geckodriver.sh
RUN sh /app/geckodriver.sh

RUN pip install --upgrade pip
RUN pip install --ignore-installed six
RUN pip install --ignore-installed urllib3
RUN pip install --upgrade pip
RUN pip install --upgrade pip==8.1.2
COPY unsubscribe/requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt



COPY unsubscribe/source/ /app/
COPY auth /auth/

ENV PYTHONPATH /app/

RUN echo "$(cat /app/main.py)\nprintAnalytics()" > /app/main.py

ENTRYPOINT ["python"]

CMD ["local.py"]
#CMD ["main.py"]

#docker build -f Dockerfile_local .
