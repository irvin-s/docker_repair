FROM continuumio/miniconda3:4.5.12 as builder

ARG COMPUTE_WPS_VER
ARG COMPUTE_SETTINGS_VER
ARG COMPUTE_WPS_VER
ARG COMPUTE_API_VER

ENV COMPUTE_API_VER ${COMPUTE_API_VER}

WORKDIR /src

COPY . .

WORKDIR /src/compute

RUN git rev-parse HEAD >> git-rev.txt && \
      conda install -c conda-forge -y conda-build=3.17.8 && \
      echo "__version__ = '${COMPUTE_SETTINGS_VER}'" >> compute_settings/compute_settings/_version.py && \
      echo "__version__ = '${COMPUTE_WPS_VER}'" >> compute_wps/compute_wps/_version.py && \
      conda build -c conda-forge -c cdat compute_settings/ && \
      conda build -c cdat/label/nightly -c cdat -c conda-forge --use-local compute_wps/

FROM continuumio/miniconda3:4.5.12

ENV COMPUTE_API_VER ${COMPUTE_API_VER}

COPY --from=builder /opt/conda/conda-bld/noarch/* /opt/conda/conda-bld/noarch/

COPY --from=builder /src/compute/git-rev.txt .

RUN export GIT_REV=$(cat git-rev.txt) && \
      rm -rf git-rev.txt

RUN conda install -c cdat/label/nightly -c cdat -c conda-forge --use-local compute-wps && \
      django-admin startproject compute && \
      mkdir -p /var/log/cwt

WORKDIR /etc/config

COPY docker/wps/django.properties .

WORKDIR /compute/compute

COPY docker/wps/settings.py .
COPY docker/wps/urls.py .
COPY docker/wps/wsgi.py .

WORKDIR /

COPY docker/wps/app.py .
COPY docker/wps/entrypoint.sh .

ENV CWT_BASE=/compute

EXPOSE 8000

ENTRYPOINT ["./entrypoint.sh"]
