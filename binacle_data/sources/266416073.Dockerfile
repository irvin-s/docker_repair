FROM quay.io/eddie_esquivel/spark-base:2.2.0
ENTRYPOINT ["/bin/bash", "-c", "./start-worker"]
