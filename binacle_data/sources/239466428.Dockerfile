FROM continuumio/miniconda3

# https://www.continuum.io/blog/developer-blog/anaconda-and-docker-better-together-reproducible-data-science
#  docker run -i -t -p 8888:8888 continuumio/anaconda3 /bin/bash -c "/opt/conda/bin/conda install jupyter -y --quiet && mkdir /opt/notebooks && /opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser"

RUN true \
	&& pip install --upgrade pip \
	&& conda install -y matplotlib \
	&& true

RUN true \
	&& apt-get update \
	&& apt-get install -y make \
	&& rm -rf /var/lib/apt/lists/* \
	&& true

# Copy requirements.txt first (they are unlikely to change)
# and install deps right after, so they are cached.
COPY requirements.txt /src/
WORKDIR /src
RUN true \
	&& pip install -r requirements.txt \
	&& pip install pytest \
	&& true

# Copy the rest of the project.
COPY . /src

RUN true \
	&& adduser dp \
	&& python setup.py install \
	&& chown -R dp:dp /src \
	&& true

USER dp
RUN find examples -name '*.json' -print0 | xargs -n 1 -0 python scripts/validate_dpkg.py --log-level=DEBUG
CMD ["make", "test"]
