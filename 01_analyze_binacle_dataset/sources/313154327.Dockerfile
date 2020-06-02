FROM iofog/python

RUN pip install jsonpath-rw

COPY . /src
RUN cd /src;

CMD ["python", "/src/main.py", "--log", "DEBUG"]