FROM python:3.6-slim
WORKDIR /app/
COPY requirements_dev.txt /
RUN pip install -r /requirements_dev.txt
COPY main.py /app/
RUN flake8
# ignore long lines
#RUN flake8 --ignore=E501
RUN pylint main.py
RUN pydocstyle main.py

FROM python:3.6-slim
ENTRYPOINT ["python", "/main.py"]
COPY requirements.txt /
RUN pip install -r /requirements.txt
COPY main.py /
