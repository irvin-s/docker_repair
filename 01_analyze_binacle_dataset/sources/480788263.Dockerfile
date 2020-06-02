FROM ubuntu:14.04

RUN apt-get update && apt-get install -q -y tcpdump python-enum python-pyasn1 scapy python-crypto python-pip python
RUN pip install scapy-ssl_tls

ADD pyx509 pyx509
ADD scapy_ssl_tls scapy_ssl_tls
ADD scanner.py scanner.py

ENTRYPOINT ["/usr/bin/env", "python", "scanner.py"]
CMD ["localhost", "443"]
