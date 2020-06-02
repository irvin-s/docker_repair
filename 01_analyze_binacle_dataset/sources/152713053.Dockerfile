FROM dockerfile/python
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
WORKDIR /code/bin
CMD ["--write-fhir","/generated"]
ENTRYPOINT  ["python", "generate.py"]
