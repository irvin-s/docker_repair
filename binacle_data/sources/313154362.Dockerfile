FROM iofog/python-arm

COPY index.py /src/
RUN cd /src;

CMD ["python", "/src/index.py", "--log", "DEBUG"]