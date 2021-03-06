FROM registry.cn-beijing.aliyuncs.com/hcamael/rsa:base
MAINTAINER Docker Hcamael <hcamael@vidar.club>

COPY rsa1.py /home/RSA/rsa1.py
COPY flag.py /home/RSA/flag.py
COPY flag /home/RSA/flag
RUN chmod +x /home/RSA/rsa1.py

USER rsa
EXPOSE 7000
CMD ["socat", "TCP4-LISTEN:7000,fork", "EXEC:\"python -u /home/RSA/rsa1.py\""]

