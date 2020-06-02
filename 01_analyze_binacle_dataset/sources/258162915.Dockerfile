ARG BASE_IMAGE

FROM ${BASE_IMAGE} as builder

WORKDIR /app
COPY . .
RUN python setup.py bdist_wheel


FROM ${BASE_IMAGE} as runtime

WORKDIR /app

# copy egg
COPY --from=builder /app/dist/deepomatic_api-*.whl /tmp/
COPY --from=builder /app/demo.py /app/
COPY --from=builder /app/tests /app/tests

RUN pip install /tmp/deepomatic_api-*.whl
