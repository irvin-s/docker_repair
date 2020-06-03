FROM fnproject/python:3.7-dev as build-stage

ARG STORAGE_ACCESS_KEY
ARG STORAGE_SECRET_KEY
ARG MINIO_SERVER_URL
ARG STORAGE_BUCKET

WORKDIR /function
ADD . /function/

RUN pip3 install --target /python/  --no-cache --no-cache-dir -r requirements.txt pytest

RUN rm -fr __pycache__ && pip3 install --no-cache --no-cache-dir -r requirements.txt && \
    STORAGE_BUCKET=${STORAGE_BUCKET} STORAGE_ACCESS_KEY=${STORAGE_ACCESS_KEY} STORAGE_SECRET_KEY=${STORAGE_SECRET_KEY} MINIO_SERVER_URL=${MINIO_SERVER_URL} pytest -v -s --tb=long func.py

FROM fnproject/python:3.7
WORKDIR /function
COPY --from=build-stage /function /function
COPY --from=build-stage /python /python
ENV PYTHONPATH=/python
ENTRYPOINT ["python3", "func.py"]
