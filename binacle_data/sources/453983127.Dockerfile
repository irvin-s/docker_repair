ARG PYTHON_VERSION=3.7

FROM python:${PYTHON_VERSION} AS build
COPY requirements*.txt /app/
COPY samples/**/requirements*.txt /app/
RUN for reqs in /app/requirements*.txt; do pip install --no-cache-dir -r $reqs; done
COPY . /app
WORKDIR /app
RUN python setup.py mypy pylint test sdist bdist_wheel \
 && pip install --no-cache-dir dist/* \
 && jupyter nbconvert samples/**/*.ipynb --to python \
 && export CI=True \
 && set -e \
 && for sample in samples/**/*.py; do python $sample; done
CMD ["/bin/bash", "-c", "bash <(curl -s https://codecov.io/bash)"]

FROM python:${PYTHON_VERSION}-slim AS samples
COPY --from=build /app/samples /samples
COPY --from=build /app/dist /dist
COPY --from=build /app/.coverage /.coverage
RUN pip install --no-cache-dir /dist/*
WORKDIR /samples
ENTRYPOINT ["python", "-m"]
CMD ["smart_speaker"]
