FROM socrata/py3_analysis

RUN pip install spacy==0.101 && python -m spacy.en.download

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/py3_spacy=""
