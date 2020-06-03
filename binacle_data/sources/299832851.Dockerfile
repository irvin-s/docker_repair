FROM python:3.7

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

VOLUME "/root/.local/share/multi_vote_bot"
CMD [ "python", "-u", "src/main.py" ]
