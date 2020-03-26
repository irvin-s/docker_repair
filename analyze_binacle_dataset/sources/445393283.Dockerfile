FROM aist-python

USER root

COPY requirements.txt /app/

WORKDIR /app

RUN pip install -r requirements.txt

COPY src /app

CMD python3 seed_form_expert_data.py
