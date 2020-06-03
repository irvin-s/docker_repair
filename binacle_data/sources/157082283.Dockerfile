FROM scratch
ADD bwa /bwa
ENTRYPOINT ["/bwa"]
