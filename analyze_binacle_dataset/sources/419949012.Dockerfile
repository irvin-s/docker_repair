FROM pypy:2-5

WORKDIR /opt/LumberMill

COPY requirements/requirements.txt ./
COPY requirements/requirements-pypy.txt ./
COPY bin ./bin
COPY conf ./conf
COPY lumbermill ./lumbermill

RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt \
 && pip install --no-cache-dir -r requirements-pypy.txt \
 && rm -f /opt/LumberMill/requirements.txt \
 && rm -f /opt/LumberMill/requirements-pypy.txt

ENTRYPOINT ["/usr/local/bin/pypy", "/opt/LumberMill/bin/lumbermill.pypy", "-c" ]