FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app/

RUN groupadd -r -g 200 bot \
        && useradd -mr -g bot -u 200 bot
USER bot

VOLUME ["/home/bot/.phenny"]

CMD ["/usr/src/app/phenny"]
