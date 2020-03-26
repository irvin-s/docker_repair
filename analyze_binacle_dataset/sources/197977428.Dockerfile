FROM kernsuite/casa:4.7
RUN docker-apt-install python-casacore python-numpy
RUN pip install simms kliko
ADD kliko.yml /
ADD kliko /
RUN chmod 755 /kliko
CMD /usr/local/bin/simms