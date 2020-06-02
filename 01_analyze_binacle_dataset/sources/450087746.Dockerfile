FROM quay.io/operator-framework/helm-operator:v0.5.0

ARG airflow_helm_version=0.7.5

RUN mkdir -p  ${HOME}/helm-charts/ && \
    wget -qO- http://helm.astronomer.io/airflow-${airflow_helm_version}.tgz | tar vxz -C ${HOME}/helm-charts/

COPY watches.yaml ${HOME}/watches.yaml
