FROM docker.io/python:2.7.13-alpine

MAINTAINER Thomas Graichen, thomas.graichen@sap.com

RUN pip install yamlconfig argparse pyVmomi prometheus-client

RUN mkdir /vcenter-exporter
ADD vcenter_util.py /vcenter-exporter/vcenter_util.py
ADD __init__.py /vcenter-exporter/__init__.py
ADD vcenter-exporter.py /vcenter-exporter/vcenter-exporter.py
ADD config.yaml /vcenter-exporter/config.yaml
