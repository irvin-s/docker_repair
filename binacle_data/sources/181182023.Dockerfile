FROM continuumio/miniconda3:4.5.12 as builder

ARG COMPUTE_PROVISIONER_VER

ARG COMPUTE_PROV_VER

WORKDIR /src

COPY . .

WORKDIR /src/compute

RUN git rev-parse HEAD >> git-rev.txt && \
      conda install -c conda-forge -y conda-build=3.17.8 && \
      echo "__version__ = '${COMPUTE_PROV_VER}'" > compute_provisioner/compute_provisioner/_version.py && \
      conda build -c conda-forge compute_provisioner/

FROM continuumio/miniconda3:4.5.12

ENV COMPUTE_PROVISIONER_VER ${COMPUTE_PROVISIONER_VER}

ENV TINI_VERSION v0.18.0

ENV FRONTEND_PORT 7777

ENV BACKEND_PORT 7778

RUN curl https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -o /tini && \
      chmod +x /tini 

COPY --from=builder /opt/conda/conda-bld/noarch/* /opt/conda/conda-bld/noarch/

COPY --from=builder /src/compute/git-rev.txt .

RUN export GIT_REV=$(cat git-rev.txt) && \
      rm -rf git-rev.txt

RUN conda install -c conda-forge --use-local compute-provisioner

EXPOSE 7777 7778

ENTRYPOINT ["tini", "--"]

CMD ["python", "-m", "compute_provisioner.load_balancer"]
