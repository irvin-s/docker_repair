FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Start Bagelbot as a Service (BaaS)
CMD [ "python", "service.py" ]
