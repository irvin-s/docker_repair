FROM kernsuite/base:dev
RUN pip install kliko==0.7.1
ADD kliko /
ADD kliko.yml /
