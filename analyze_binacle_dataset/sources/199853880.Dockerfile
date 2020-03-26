FROM geowa4/rpi-blue-python
ENTRYPOINT ["/whoisit.py"]
COPY whoisit.py /whoisit.py
