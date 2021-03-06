FROM continuumio/anaconda

ADD . /code
WORKDIR /code

COPY daily_batch.sh /daily_batch.sh
COPY get_raw_data.py /get_raw_data.py
COPY extract_features.py /extract_features.py
COPY get_related_news.py /get_related_news.py
COPY feed_to_redis.py /feed_to_redis.py
COPY app.py /app.py
COPY dict/ /dict/
COPY fallback/ /fallback/

RUN set -x \
    && conda install -c conda-forge python-annoy=1.8.3 \
    && conda install -c conda-forge jieba=0.38 \
    && pip install -r requirements.txt

EXPOSE 8080
CMD ["python", "app.py"]
