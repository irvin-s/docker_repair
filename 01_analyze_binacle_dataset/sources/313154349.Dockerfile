FROM iofog-python-arm

COPY diagnostic.py /src/
WORKDIR  /src
CMD ["python", "diagnostic.py"]
