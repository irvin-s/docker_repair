FROM crossbario/autobahn-python-armhf

# install component specific dependencies and remove default content
RUN apt-get update && \
    apt-get install -y libsdl-dev

RUN pip install pyopenssl service_identity

RUN pip install python-rtmidi

RUN rm -rf /app/*

# copy the component into the image
COPY ./app /app

# start the component by default
CMD ["python", "-u", "client.py"]
