FROM python:2.7.11

ENV ELASTICKUBE_PATH    /opt/elastickube
ENV PYTHONPATH          /opt/elastickube
ENV KUBE_API_TOKEN_PATH /var/run/secrets/kubernetes.io/serviceaccount/token

WORKDIR ${ELASTICKUBE_PATH}

RUN pip install --no-compile tornado futures

ADD diagnostics ${ELASTICKUBE_PATH}/diagnostics

CMD python ${ELASTICKUBE_PATH}/diagnostics/diagnostics.py
