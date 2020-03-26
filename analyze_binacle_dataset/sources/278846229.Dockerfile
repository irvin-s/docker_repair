# Official Jupyter Notebook at commit ef9ef707038d
# refered to https://github.com/jupyter/docker-stacks/wiki/Docker-build-history
# exposing port 8888
FROM jupyter/datascience-notebook:ef9ef707038d


# Install k8s python client and flask
RUN pip install --upgrade pip

RUN pip install git+https://github.com/kubernetes-incubator/client-python.git

RUN pip install Flask
RUN pip install kafka-python \
    && pip2 install kafka-python
RUN pip install avro \
    && pip2 install avro
RUN pip install avro-python3

RUN pip install Flask joblib


EXPOSE 5000

COPY jupyter_notebook_config.py /home/jovyan/.jupyter/jupyter_notebook_config.py
ADD ./utils/ ./utils/
RUN jupyter trust ./utils/*.ipynb
ADD ./examples/ ./examples/
RUN jupyter trust ./examples/*.ipynb

# Get kafka
RUN wget "http://mirror.cc.columbia.edu/pub/software/apache/kafka/0.10.2.0/kafka_2.11-0.10.2.0.tgz" \
    && tar -xzf kafka_2.11-0.10.2.0.tgz \
    && rm -rf kafka_2.11-0.10.2.0.tgz

USER root

RUN chown jovyan:users /home/jovyan/.jupyter/jupyter_notebook_config.py
RUN chown -R jovyan:users ./utils
RUN chown -R jovyan:users ./utils/*
RUN chown -R jovyan:users ./examples
RUN chown -R jovyan:users ./examples/*

# RUN pip install jgscm # leads to an error when building the image

#Add the name of the authentication json here:
COPY Kubeyard-auth.json /usr/jupyter/Kubeyard-auth.json
ADD startup.sh /usr/jupyter/startup.sh
RUN chmod +x /usr/jupyter/startup.sh

USER $NB_USER

RUN wget https://dl.google.com/dl/cloudsdk/release/install_google_cloud_sdk.bash
RUN bash install_google_cloud_sdk.bash --disable-prompts
RUN rm install_google_cloud_sdk.bash

ENV PATH="/home/jovyan/google-cloud-sdk/bin:${PATH}"

RUN gcloud auth activate-service-account --key-file=/usr/jupyter/Kubeyard-4d3b8ff40d2b.json

CMD ["/usr/jupyter/startup.sh"]
