FROM ubuntu:14.04
RUN apt-get update && apt-get -y install python-setuptools build-essential python-dev libffi-dev libssl-dev
RUN easy_install pip
RUN pip install urllib3[secure]==1.15.1
RUN pip install Flask==0.10.1
RUN pip install boto==2.39.0
RUN pip install hvac==0.2.10
RUN pip install tornado==4.3
RUN pip install requests==2.9.1
RUN pip install boto3==1.3.0
EXPOSE 5001
ADD . /src/
CMD ["python", "/src/run_server.py"]
