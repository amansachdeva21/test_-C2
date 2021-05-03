**Steps and pre-req for getting the metadata key from GCP instance**

**Pre-req/Requirement**
- Service account Json key from GCP.
- This key should be place in "account.json" file and this file should be in the same location where the "metadata.sh" is kept

**How to run the metadata.sh**
- metadata.sh requires **3 mandatory parameters** and **one optional parameter**. This optional parameter will used when you want to fetch the value for particular key:-
  - instance-name - Name of the instance for which metadata is required for
  - project-name - name of the project where the instance exists
  - zone - zone where the instance exits
  - key **(optional)** - the metadata key for which the value need to be fetched

- How to run the script to get the output:-
  - **For fetching all the metadata keys and value we use**:-
    ./metadata.sh instance-name project-name zone
    For example:-
    ./metadata.sh instance1 test-project us-east1-c
    
  - **For retrieved the particular data key** we need to provide the 4th parameter while runnig the shellscript:-
    ./metadata.sh instance-name project-name zone key
    For example:-
    ./metadata.sh instance1 test-project us-east1-c test-key
