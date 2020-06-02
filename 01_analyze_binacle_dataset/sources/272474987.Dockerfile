FROM derekadair/python-workflow:2.7

WORKDIR app
COPY . /app
RUN pip install --no-cache-dir -r requirements.in
