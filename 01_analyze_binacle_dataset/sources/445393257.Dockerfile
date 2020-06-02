FROM aista/python

ARG app_dir=deployment/aist-python

COPY $app_dir/requirements.txt /app/

WORKDIR /app

RUN pip install -r requirements.txt

COPY common/dist/aist_common-0.0.1-py3-none-any.whl /app

RUN pip install aist_common-0.0.1-py3-none-any.whl

RUN pip install supervisor-stdout