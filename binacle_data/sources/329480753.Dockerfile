FROM python:2.7.13-alpine

COPY app /opt/docker-swarm-service-autoscaler/app

RUN pip install -r /opt/docker-swarm-service-autoscaler/app/requirements.txt

WORKDIR /opt/docker-swarm-service-autoscaler

ENTRYPOINT ["python", "-m", "app.main"]
