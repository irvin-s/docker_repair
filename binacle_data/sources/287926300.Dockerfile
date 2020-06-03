FROM python:3.6

COPY requirements.txt /requirements.txt
# sparsesvd dependensies are broken, so we have to install Cython and numpy separately
RUN pip3 install Cython==0.27.3
RUN pip3 install numpy==1.14.0
RUN pip3 install -r /requirements.txt

COPY . /app/
WORKDIR /app/

CMD python3 server.py
