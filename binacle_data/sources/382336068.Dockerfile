FROM leastauthority/base

COPY requirements.txt /s4/requirements.txt

RUN /app/env/bin/pip install --find-links=https://tahoe-lafs.org/deps --requirement /s4/requirements.txt

COPY . /s4
RUN /app/env/bin/pip install --no-index /s4
