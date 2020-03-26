FROM python:3.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy source
COPY . .

RUN python setup.py install

ENTRYPOINT [ "python" ]

CMD [ "examples/receive.py" ]
