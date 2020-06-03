FROM python:2.7-slim
RUN apt-get update -qqy && \
	apt-get -qqy install wget curl git && \
	rm -rf /var/lib/apt/lists/*
# show python logs as they occur
ENV PYTHONUNBUFFERED=0

# get packages
WORKDIR /pythonservice
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# add files into working directory
COPY . .

# set listen port
ENV PORT "10401"
EXPOSE 10401 10402 10403

ENTRYPOINT ["python", "/pythonservice/both.py"]
