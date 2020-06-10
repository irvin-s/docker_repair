# Automatic Docker repair
 This tool try to suggest possible repairs for broken Dockerfiles using NLP.

 ## Usage / Setup
To use the automatic Dockerfiles repair, use Linux, and install the following requirements.

- Latest version: 

`Docker`
`Python3`
`pip3`
`Linux`

### 01 - Build Dockerfiles

- Before executing the building, insert the Dockerfiles names in: `image_list.txt`

- To select what Dockerfiles to build see: `notes/sizesortedlist-dockerfiles.txt`
    - The filename must have this format `sources/228568839.Dockerfile`

- To build Dockerfiles run the script:
    `./build_test.sh`

- After run the script see Logs at:
    `logs/`
    - Logs for build failure `logs/fail`, and success `logs/success`

### 02 - Generate Keywords from logs

- Before using the scripts install the requirements located in the `requirements.txt`
    - To install run this: `pip3 install -r requirements.txt`

- To automatic verify the failed logs run python script located at `keywords_gen/`

- Run the python script using the following syntax:
    `python3 query_process.py ../logs/fail/228568839.log`

### 03 - Check query results

- Check the created keyword and the URLs for a possible fix recommendation at: `results/analyzed_query.json`

 ## Preliminaries

This repository work is in-flux, at this time there are only a few pre-results. The dataset of Dockerfiles must be in Context to avoid misconfiguration errors. We are using TF-IDF to generate the keywords, first, we tried to use the RAKE algorithm, but we can't get good results.