# Build
FROM python:3-alpine
WORKDIR /a
COPY setup.py .
COPY cloudkeeper cloudkeeper
RUN python setup.py bdist_wheel

# Run
FROM python:3-alpine
WORKDIR /a
COPY --from=0 /a/dist/*.whl .
RUN pip install --no-cache-dir cloudkeeper-*.whl
CMD ["python", "-m", "cloudkeeper"]
