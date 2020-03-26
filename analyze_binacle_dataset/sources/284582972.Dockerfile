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


WORKDIR /app

ENV PATH="/app:${PATH}"

COPY unsubscribe/geckodriver.sh /app/geckodriver.sh
RUN sh /app/geckodriver.sh

COPY unsubscribe/requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt



COPY unsubscribe/source/ /app/
COPY auth /auth/

ENV PYTHONPATH /app/

ENTRYPOINT ["python"]

CMD ["seltest.py"]
