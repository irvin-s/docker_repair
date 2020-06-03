FROM arachnado

WORKDIR /undercrawler

COPY requirements.txt .
RUN pip install -r requirements.txt && \
    formasaurus init
COPY . .
RUN pip install -e .
