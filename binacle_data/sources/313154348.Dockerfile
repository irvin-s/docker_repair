FROM iofog-python

COPY diagnostic.py /src/
WORKDIR  /src
CMD ["python", "diagnostic.py"]
