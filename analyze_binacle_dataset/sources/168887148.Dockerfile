FROM socrata/py_nltk

RUN pip install Flask>=0.10.1 \
                flask-restful==0.3.2

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/py_analyserver=""
