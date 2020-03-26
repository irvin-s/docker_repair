FROM python

ARG INDICO_API_KEY
ARG INDICO_API_HOST

RUN apt-get update && \
  apt-get -y upgrade && \
  pip install indicoio && \
  pip install pytest && \
  pip install pytest-parallel && \
  pip install pytest-html && \
  pip install ipython && \
  pip install teamcity-messages && \
  mkdir /app

COPY . /app/

WORKDIR /app

RUN pip install -r requirements.txt

ENV INDICO_API_KEY=$INDICO_API_KEY
ENV INDICO_API_HOST=$INDICO_API_HOST

CMD ["pytest", "-v", "--worker", "1", "--html=./tests/artifacts/report.html"]
