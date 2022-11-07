# CA675_CA1
Assignment 1 - Data Analysis

CA675 - Cloud Technologies

## Tasks

### Task 1: Cloud Infrastructure Setup (AWS, GCP, Azure, …)

1. Task 1.1: Install Hadoop and create a Hadoop cluster
2. Task 1.2: Install MapReduce, Pig and Hive to use the cluster created in Task 1.1 

#### Setting up the AWS EMR Cluster

1. Set up a virtual private cloud (VPC)
2. Set up the AWS Cloud9 Environment
3. Create an EC2 Key Pair
4. Upload the key pair to Cloud9 IDE
5. Set up S3 Storage Bucket with the folders: Input, Output and Files
6. Create EMR cluster and configure with Hadoop, Hue Hive, Pig and Spark.
7. SSH into the cluster in the IDE using the key pair and private IPV4 address of the cloud9.

### Task 2: Dataset

1. Task 2.1: Choose a relevant dataset (should be justified)
2. Task 2.2: Get data from any public dataset repository
3. Task 2.3: Load data into chosen cloud technology (AWS, GCP, Azure, …)

- Two CSV files, "toys" and "sports", are avaialbe to download in the data folder.
- This data was sourced from kaggle: https://www.kaggle.com/datasets/naveedhn/amazon-product-review-spam-and-non-spam?select=Electronics
- And the "data_to_csv_ script was used to convert the json files to csv. Data to csv.py
- The csv files were uploaded to the "Input" folder of our S3 Bucket. Bucket/input/toys & Bucket/input/sports

### Task 3: Clean and process the data using Pig

Once uploaded we head to the Cloud9 CLI and open the grunt shell (pig;)
- Apply the pig script in the code folder: pig_clean_step.pig

The output of the script will serve as the "input" for Task 4.

### Task 4: Ham and Spam using Hive

1. Task 4.1: Query processed data to differentiate ham and spam part of the dataset
2. Task 4.2: Find the top 10 spam accounts
3. Task 4.3: Find the top 10 ham accounts

Next we are to query the top 10 Ham and Spam accounts using hive (hive;)
- Run the top_10_ham.hql and top_10_spam.hql scripts in the code folder.
- The output of this identifies the top 10 reviewer IDs in both the ham and the spam dataset. You can see there are some accounts which are prolific spammers.

### Task 5: TF-IDF using MapReduce

1. Task 5.1: Use MapReduce to calculate the TF-IDF of the top 10 spam keywords for each top
10 spam accounts
2. Task 5.2: Use MapReduce to calculate the TF-IDF of the top 10 ham keywords for each top
10 ham accounts

Run the Pig_tokenize.pig script to clean the summary column and tokenize the cleaned column. TF-IDF to be completed.
