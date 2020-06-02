FROM certbot/certbot

COPY . src/certbot-dns-namecheap

RUN pip install --no-cache-dir --editable src/certbot-dns-namecheap
