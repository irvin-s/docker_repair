FROM ubuntu:16.04
RUN apt-get update && apt-get install -y python-dicom
ADD . /prog
WORKDIR /prog
ENTRYPOINT ["python", "cmd.py"]
LABEL com.envoyai.metadata-version=2
LABEL com.envoyai.schema-in="\
input-image: { dicom-type: dicom-image }\n\
finding: {enum: [ 'pneumothorax' , 'pneumonia' ] }"
LABEL com.envoyai.schema-out="\
pneumothorax: { type: string }\n\
pneumonia-present: { type: boolean }"
LABEL com.envoyai.report="\
findings:\n\
  - code: '36118008'\n\
    code-system: snomed-ct\n\
    value:\n\
      pointer:\n\
        source: output\n\
        property: pneumothorax\n\
  - code: 'RID5350'\n\
    code-system: radlex\n\
    value:\n\
      pointer:\n\
        source: output\n\
        property: pneumonia-present"
LABEL com.envoyai.info="\
name: Findings Demo\n\
title: Demonstration for returning radiology report findings.\n\
author: Staff\n\
organization: EnvoyAI"
