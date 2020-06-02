FROM ubuntu:18.04

RUN apt-get update && apt-get install -y python3 python3-pip

# Dash and dependencies
RUN pip3 install dash==0.39.0  # The core dash backend
RUN pip3 install dash-renderer==0.20.0  # The dash front-end
RUN pip3 install dash-html-components==0.14.0  # HTML components
RUN pip3 install dash-core-components==0.44.0  # Supercharged components
RUN pip3 install dash-daq==0.1.4

RUN pip3 install pandas==0.24.1
RUN pip3 install numpy==1.16.2

RUN pip3 install scikit-learn
RUN pip3 install gunicorn

RUN mkdir app
COPY app/* /app/

EXPOSE 8050

WORKDIR /app
CMD ["gunicorn","-b", "0.0.0.0:8050", "app:server"]
