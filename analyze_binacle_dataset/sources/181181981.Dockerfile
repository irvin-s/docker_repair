FROM continuumio/miniconda3:4.5.12 as builder

ARG COMPUTE_CELERY_VER
ARG COMPUTE_KUBERNETES_VER
ARG COMPUTE_TASKS_VER
ARG COMPUTE_PROVISIONER_VER
ARG COMPUTE_API_VER

ENV COMPUTE_API_VER ${COMPUTE_API_VER}

WORKDIR /src

COPY . .

WORKDIR /src/compute

RUN git rev-parse HEAD >> git-rev.txt && \
      conda install -c conda-forge -y conda-build=3.17.8 && \
      echo "__version__ = '${COMPUTE_KUBERNETES_VER}'" > compute_kubernetes/compute_kubernetes/_version.py && \
      echo "__version__ = '${COMPUTE_PROVISIONER_VER}'" > compute_provisioner/compute_provisioner/_version.py && \
      echo "__version__ = '${COMPUTE_TASKS_VER}'" > compute_tasks/compute_tasks/_version.py && \
      conda build -c conda-forge -c cdat compute_kubernetes/ && \
      conda build -c conda-forge compute_provisioner/ && \
      conda build -c cdat/label/nightly -c cdat -c conda-forge --use-local compute_tasks/

FROM continuumio/miniconda3:4.5.12

ENV COMPUTE_API_VER ${COMPUTE_API_VER}

ENV COMPUTE_CELERY_VER ${COMPUTE_CELERY_VER}

ENV prometheus_multiproc_dir /metrics

COPY --from=builder /opt/conda/conda-bld/noarch/* /opt/conda/conda-bld/noarch/

COPY --from=builder /src/compute/git-rev.txt .

RUN export GIT_REV=$(cat git-rev.txt) && \
      rm -rf git-rev.txt

RUN mkdir -p /tmp/certs && \
      curl -sL https://github.com/ESGF/esgf-dist/raw/master/installer/certs/esg_trusted_certificates.tar | tar xvf - -C /tmp/certs --strip 1

RUN conda install -c cdat/label/nightly -c cdat -c conda-forge --use-local compute-tasks

WORKDIR /

COPY docker/celery/entrypoint.sh .

COPY docker/celery/healthcheck.sh .

EXPOSE 8000

ENTRYPOINT ["tini", "--"]

CMD ["/bin/bash", "./entrypoint.sh", "-c", "1", "-Q", "default", "-n", "default", "-l", "INFO"]
