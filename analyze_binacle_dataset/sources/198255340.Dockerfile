FROM python:2.7

LABEL maintainer "lucas@spideroak-inc.com"

# Update pip
RUN pip install --upgrade \
    pip

# Download and install Semaphor
RUN wget https://spideroak.com/releases/semaphor/debian \
    && dpkg -i debian \
    && rm -rf debian

COPY . /flow-python
WORKDIR /flow-python

# Install flow-python
RUN pip install -r requirements.txt \
&& pip install .

# Execute python to start using flow-python
CMD python
