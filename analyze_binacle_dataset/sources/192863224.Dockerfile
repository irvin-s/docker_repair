FROM python:2.7
MAINTAINER Justin Littman <justinlittman@gwu.edu>

#Add files
ADD . /orcid2vivo
RUN pip install -r /orcid2vivo/requirements.txt
EXPOSE 5000
WORKDIR /orcid2vivo
CMD python orcid2vivo_service.py --endpoint $O2V_ENDPOINT --username $O2V_USERNAME --password $O2V_PASSWORD --namespace $O2V_NAMESPACE --debug
