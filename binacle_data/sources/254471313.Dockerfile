FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y build-essential socat python

#user
RUN adduser --disabled-password --gecos '' k
RUN chown -R root:k /home/k/
RUN chmod 750 /home/k
WORKDIR /home/k/


COPY ./challserv.py /home/k/
COPY ./b64strs.txt /home/k/

RUN chmod 777 /home/k/challserv.py
RUN chmod +r /home/k/b64strs.txt

CMD su k -c "socat TCP-LISTEN:9227,reuseaddr,fork EXEC:/home/k/challserv.py"

