FROM continuumio/miniconda3:4.5.12 as builder

ARG COMPUTE_KUBE_MONITOR_VER
ARG COMPUTE_KUBERNETES_VER

WORKDIR /src

COPY . .

WORKDIR /src/compute

RUN git rev-parse HEAD >> git-rev.txt && \
      conda install -c conda-forge -y conda-build=3.17.8 && \
      echo "__version__ = '${COMPUTE_KUBERNETES_VER}'" > compute_kubernetes/compute_kubernetes/_version.py && \
      conda build -c conda-forge -c cdat compute_kubernetes/

FROM continuumio/miniconda3:4.5.12

ENV COMPUTE_KUBERNETES_VER ${COMPUTE_KUBERNETES_VER}

COPY --from=builder /src/compute/git-rev.txt .

RUN export GIT_REV=$(cat git-rev.txt) && \
      rm -rf git-rev.txt

COPY --from=builder /opt/conda/conda-bld/noarch/* /opt/conda/conda-bld/noarch/

RUN conda install -c conda-forge -c cdat --use-local compute-kubernetes

ENTRYPOINT ["compute-kube-monitor"]
