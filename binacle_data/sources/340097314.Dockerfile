FROM python:3.7.3-slim

# Setup dependencies in a cacheable step
ADD spawn_data_pipeline_requirements.txt /code/

RUN pip install --disable-pip-version-check --no-cache-dir -r /code/spawn_data_pipeline_requirements.txt

ADD spawn_data_pipeline.py /code

ADD data-pipeline.yml /code
ADD check-pipeline.yml /code

CMD python /code/spawn_data_pipeline.py
