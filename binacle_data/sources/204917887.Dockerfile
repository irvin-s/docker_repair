FROM python:2
MAINTAINER Josh Mandel
RUN mkdir /tasks
WORKDIR /tasks

RUN apt-get update && \
    apt-get install -y netcat curl

# Create sample data for stu3 and stu2 specifications.
# This gets baked into the image so it can be posted to the
# FHIR server later.
COPY sample-patients sample-patients
COPY sample-patients-stu3 sample-patients-stu3

RUN cd sample-patients && \
    pip install -r requirements.txt && \
    cd bin && \
    python generate.py --write-fhir ../generated-data && \
    cd /tasks && \
    mv sample-patients/generated-data patients-stu2 && \
    rm -rf sample-patients

RUN cd sample-patients-stu3 && \
    pip install -r requirements.txt && \
    cd bin && \
    python generate.py --write-fhir ../generated --id-prefix smart && \
    cd /tasks && \
    mv sample-patients-stu3/generated patients-stu3 && \
    rm -rf sample-patients-stu3

ENV PATH /tasks:$PATH

COPY load-sample-data-stu2 /tasks/load-sample-data-stu2
COPY load-sample-data-stu3 /tasks/load-sample-data-stu3

COPY register-client /tasks/register-client

CMD ["echo", "short-running-task-service-closing-now"]
