FROM python:2.7-slim AS build-env
ADD . /app
WORKDIR /app
RUN pip install --upgrade pip
RUN pip install -r ./requirements.txt

FROM gcr.io/distroless/python2.7
COPY --from=build-env /app /app
COPY --from=build-env /usr/local/lib/python2.7/site-packages /usr/local/lib/python2.7/site-packages
WORKDIR /app
ENV PYTHONPATH=/usr/local/lib/python2.7/site-packages
CMD ["app.py"]


