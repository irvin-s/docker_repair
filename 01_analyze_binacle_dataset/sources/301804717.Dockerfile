FROM continuumio/miniconda3

MAINTAINER Dmitry Ustalov <dmitry.ustalov@gmail.com>

EXPOSE 5000

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN \
conda install -y -c conda-forge numpy scipy scikit-learn misaka uwsgi && \
sed -rn '/(numpy|scipy|scikit-learn|gensim|misaka|uwsgi)/!p' -i requirements.txt && \
pip install --no-cache-dir -r requirements.txt && \
conda clean -a

RUN \
curl -sL https://download.cdn.yandex.net/mystem/mystem-3.0-linux3.1-64bit.tar.gz | tar zx && \
mv mystem /bin && \
chmod +x /bin/mystem

COPY . .

RUN ./mnogoznal_web_assets.py

USER nobody

CMD ["uwsgi", "--http", "0.0.0.0:5000", "--master", "--module", "mnogoznal_web:app", "--processes", "4", "--threads", "1", "--harakiri", "30"]
