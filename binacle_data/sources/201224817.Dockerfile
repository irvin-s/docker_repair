#FROM python:3-slim
FROM pypi/matplotlib

COPY requirements.txt .

RUN  sed -i.bak '/matplotlib/d' requirements.txt && \
	pip3 install --upgrade --no-cache-dir pip && \
	pip3 install --no-cache-dir -r requirements.txt && \
   	 rm -rf ~/.cache/pip

RUN mkdir -p /bot-mv-telegram
WORKDIR /bot-mv-telegram/

COPY . .

CMD ["python3","bot.py"]
