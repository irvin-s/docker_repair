FROM iofog/python-arm

RUN pip install jsonpath-rw

COPY . /src
RUN cd /src;

CMD ["python", "/src/main.py", "--log", "DEBUG"]