# Automatic Dockerfiles repair
 This tool tries to localize posts on discussion forums
with answers to build problems in Dockerfiles.

 ## Usage / Setup
To use the automatic Dockerfiles repair, use Linux, and install the following requirements.

- Latest version: 

- `Docker`
- `Python3`
- `pip3`
- `Linux`

Install our requirements:

```
pip3 install -r requirements.txt
```

### 01 - Build Dockerfiles

- Before executing the building, insert the Dockerfiles names in: `image_list.txt`

- To select what Dockerfiles to build see: `${ROOT_DIR}/notes/sizesortedlist-dockerfiles.txt`
    - The filename must have this format `sources/228568839.Dockerfile`

- To build Dockerfiles run the script:

```
./build_test.sh
```

- The generated logs will be located under directory `${ROOT_DIR}/logs/`. Logs for build failures
  will be at `${ROOT_DIR}/logs/fail` and logs of successful builds will be at `${ROOT_DIR}/logs/success`.

- Files that contais "returned a non-zero code" will be in `${ROOT_DIR}/results/files_to_analyze.log`

### 02 - Generate Keywords from logs

- cd to directory `${ROOT_DIR}/query_proc`

- The following script processes a log file to generate a list of keywords and URLs 
that contains fix recommendations. Dockerfiles located in `${ROOT_DIR}/results/files_to_analyze.log` will be processed.

For example:

```
python3 keyword_creator.py
```

### 03 - Check query results

- Check the output at: 

```
${ROOT_DIR}/results/analyzed_query.json.
```

 - Analyzed query exemple:
 
 ```
 {
    "Hash: 154176094": [
        {
            "Log fragment": "E: The repository 'http://archive.ubuntu.com/ubuntu artful-updates Release' does not have a Release file.  E: The repository 'http://archive.ubuntu.com/ubuntu artful-backports Release' does not have a Release file.  \u001b[0mThe command '/bin/sh -c apt-get update -qq -y' returned a non-zero code: 100 ",
            "Query": "ubuntu release a e the repository http archive",
            "URLs": {
                "0": "https://askubuntu.com/questions/1120194/e-the-repository-http-archive-canonical-com-precise-release-is-not-signed",
                "1": "https://askubuntu.com/questions/996718/ubuntu-repository-does-not-have-a-release-file"
            }
        }
    ]
}
 ```

 ## Preliminaries

This repository work is in-flux, at this time there are only a few pre-results. The dataset of Dockerfiles must be in Context to avoid misconfiguration errors. We are using TF-IDF to generate the keywords, first, we tried to use the RAKE algorithm, but we can't get good results.