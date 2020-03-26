FROM python:3.5

WORKDIR /usr/src/app

COPY siha\'s_diary4.zip .
COPY run.sh ./
COPY requirements.txt ./

RUN apt update && apt upgrade -y
RUN apt install -y sqlite3 libsqlite3-dev unzip

RUN unzip siha\'s_diary4.zip
RUN pip install --no-cache-dir -r requirements.txt
RUN ./run.sh

ENV SECRET_KEY 51h4_5up3r_53cr37_fl45k_k3y_h4h4_h0h0
ENV DB_PATH sqlite:////tmp/5up3r_53cur3_db_l0c4710n.db

EXPOSE 5000

CMD flask run --host 0.0.0.0

