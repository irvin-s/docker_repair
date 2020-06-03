FROM python:2.7
RUN apt-get update && apt-get install unzip
ADD . /code/
WORKDIR /code/
RUN pip install -r requirements.txt
VOLUME /data
WORKDIR /code/nppes_fhir_demo
EXPOSE 8080
RUN useradd -ms /bin/bash nppes_server
RUN chown -R  nppes_server.nppes_server /code 
RUN chown -R  nppes_server.nppes_server /data
USER nppes_server
CMD ["gunicorn","-b","0.0.0.0:8080", "serve_nppes:app"]
