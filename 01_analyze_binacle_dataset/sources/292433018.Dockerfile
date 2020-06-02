FROM python:3.6-slim

# Alternatively use ADD https:// (which will not be cached by Docker builder)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    build-essential \
    && curl -sSL https://github.com/openfaas-incubator/of-watchdog/releases/download/0.4.1/of-watchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog

WORKDIR /root/

COPY requirements.txt   .
RUN pip install -r requirements.txt

COPY index.py .
COPY handler.py .

ENV fprocess="python index.py"
ENV cgi_headers="true"
ENV mode="http"
ENV upstream_url="http://127.0.0.1:5000"

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
