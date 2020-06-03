FROM registry.aliyuncs.com/acs-sample/python:2.7
RUN pip install selenium nose
COPY test_baidu.py .
COPY test_yunqi.py .
CMD ["sh", "-c", "sleep 15 && nosetests"]