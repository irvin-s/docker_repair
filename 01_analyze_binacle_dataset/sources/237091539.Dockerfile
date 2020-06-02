FROM python:3.4-alpine
RUN apk add --no-cache git bash
RUN git clone https://github.com/Plazmaz/Sublist3r.git
WORKDIR /Sublist3r/
RUN pip install -r requirements.txt
ENTRYPOINT ["/bin/bash"]
