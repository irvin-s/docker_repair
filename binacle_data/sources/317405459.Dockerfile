FROM python:2.7

RUN apt update -y && \
    apt install -y pandoc && \
    pip install twine pypandoc

WORKDIR /app

COPY . .

ENTRYPOINT ["/bin/bash"]
