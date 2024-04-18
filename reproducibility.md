## Set up the environment

## Google Cloud Platform

For this project you can create a free trial on GCP; you can sign-up [here](https://cloud.google.com/free). Remember, you'll have access to $300 worth of credit to spend for three months. 

### Creating a service account
1. Navigate to [IAM & Admin](https://console.cloud.google.com/iam-admin/iam?project=de-zoomcamp-test) and create a new service account with the following credentials:

* Viewer
* Storage Admin
* Storage Object Admin
* BigQuery Admin

2. You can download service account key for the authentication process

3. If you want to move your files from your VM to your laptop, you will need to download the [Gcloud SDK](https://cloud.google.com/sdk/docs/install-sdk) and note that gcloud session is required.

```
export GOOGLE_APPLICATION_CREDENTIALS="<path/to/your/service-account-authkeys>.json"

gcloud auth application-default login
```

### Creating a VM

In order to run everything in the cloud you'll need to set a virtual machine in google cloud plafform, you need to set up an ubuntu machine and install all the packages needed to do the course like Terraform, Docker and Mage.

1. Login into your google cloud profile to [Compute Engine](https://console.cloud.google.com/compute/instances?) and click create instance. 
<img width="1362" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/3c4f7430-1d09-4c85-9750-337345a7b542">

You can set up this features:

> **boot disk:** Ubuntu, 20.04 LTS, 30gb <br/>
> **machine type:** e2-standard-4 <br/>
> **vCPU:** 4 <br/>
> **Memory:** 16gb

2. Create a key [ssh key](https://cloud.google.com/compute/docs/connect/create-ssh-keys#gcloud) to access the VM and add the public key to GCP in compute engine --> metadata --> add ssh key

3. You need to create a file in the following path in your local machine at .ssh/config and everytime you stop and open your virtual machine to avoid running out of credit,you'll need to edit the external ip. Once the file is saved you can run sftp de-zoomcamp and you can connect to your vm and start to work. You just need to set up the following fields and run ssh de-zoomcamp in your terminal.

   
Host de-zoomcamp

    HostName external ip for your computed engine
    
    User username
    
    IdentityFile /Users/username/.ssh/gpc - location of your personal key

## Desployment of the infrastructure

In this project I have used Terraform. This is a valuable tool in data engineering projects for managing and provisioning infrastructure as code (IaC). Here are some common use cases for Terraform in data engineering projects:

Cloud Resource Provisioning: Terraform can be used to provision and manage cloud resources such as virtual machines (VMs), storage buckets, databases, networking components (e.g., VPCs, subnets, firewall rules), and other infrastructure components required for data engineering workloads.

Infrastructure Automation: Terraform allows you to automate the creation, configuration, and management of infrastructure resources, reducing manual effort and ensuring consistency across environments. This is particularly useful in data engineering projects where you may need to provision and tear down infrastructure frequently for testing, development, and production environments.

It is really usefull because you can edit each block ( Load, Transformation and Export),create new pipelines based on the testing models available easily and very intuitive.

 ## Steps to install

1. You need to set up the variables.tf file, you need to set up the credentials field with your key, the name of your project and the name of your bucket.
   
    <img width="449" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/b3c82104-5bc2-477d-a435-f845534f0be5">
    

3. Also you need to set up main.tf file.
 
4. Run ``` terraform init ```

5. run ``` terraform apply ```  to deploy the resources.

6. Now you will see your bucket and your big query data set in the cloud already deployed.
In order to access to your bucket click here (https://console.cloud.google.com/storage/) and you'll access to your big query dataset click here[(https://console.cloud.google.com/bigquery?)

### Destroy resources- important
Be sure to remove all your resources before your free trial expires running the following command 'terraform destroy'


## Mage Orchestraction step

In order to build the ETL process, we are going to use this useful platform Mage. Mage is a popular tool used for creating build and automation pipelines.

We are going to load the data from our GCS bucket previously deployed in Terraform, doing same transformations, basically cleanning and unnesting same columns because the data is build in json data type and finally, we will push the data in the GCS bucket again


## Setting up Mage instructions

Run the following command in your terminal.

```git clone https://github.com/mage-ai/compose-quickstart.git```

1. Access to the mage-ai folder and build the container ```docker compose build```
2. Start the docker container running ```docker compose up```
3. Access to ```localhost:6789``` - you will need to open the port 6789 in your VSCode to get access to the web service.

<img width="611" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/9db4e496-62cd-45ee-8ead-de29a53262f3">

## Configuring Mage to get permissions to GCS

In order to upload the data to your GCS Bucket, you'll need to configure Mage to authenticate with GCP using the path of your key in your virtual machine. You will need to open the io_config.yaml file and modify the field Google_service. 

```
GOOGLE_SERVICE_ACC_KEY_FILEPATH: "/home/src/{key credentials}.json"
GOOGLE_LOCATION: EU # Optional
```

## Creating an external table

Finally, once you have the data in your bucket, you need to create a database and external table in Big Query. You can create a external table running the following code.

```
CREATE OR REPLACE EXTERNAL TABLE `database.schema.your_table`
OPTIONS (
  format = 'csv',
  uris = ['gs://bucket/data_folder/*.csv']
)
;

```
Once you run the query, you will see the table in your BigQuery Studio section.

<img width="305" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/e8a9d7a2-d7c7-4225-a69e-8de153d10f33">

## Modelling using dbt

In order to model our data once the data is loaded in our data warehouse (BigQuery). I am going to use the star schema principle ( Kimball Modelling Technique). The key thing of this technique is building a dimension tables and a final fact table to execute queries to do futher analysis in a structure way. Another advantage is its focus on simplicity, flexibility, and user-friendliness, which allows organizations to efficiently capture and represent business data in a way that is intuitive and easily understandable by business users.

Using dbt (Data Build Tool) in data engineering projects offers several benefits for modeling and transforming data. These are the main key advantages: Modularization,Version control, Documentation, testing,Dependency Management,Incremental Builds,Execution Environment and Community and Ecosystem.

## Get access to dbt

1-Create a new service account for dbt with the BigQuery Admin role and generate a key.
2-Create a new dbt account (https://cloud.getdbt.com/)
3-create a new dbt cloud project, you need to select the BigQuery for your datawarehouse connection,
after that you  need upload your service account key and all the fields will be automatically populated.

Finally, you will have access to the developer section in dbt cloud.

## Development step

Firstly, you need to create a schema.yml file under stanging folder.

Here you need to set up, the name of the model, database name and schema and after that you need to type all the column names, description and data type for all the column of your data model.

<img width="905" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/3b9e7882-c6a0-4f41-9074-8d4a10b630c7">

After that, you need to create your stg model running the following code:

```
{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging_rawg', 'games') }}

),

renamed as (

    select
        id as id_game,
        name,
        tba,
        released,
        rating,
	    rating_top,
        exceptional,
	    recommended,
	    meh,
	    skip,
	    playtime,
	    metacritic,
	    reviews_count,
	    esrb_rating_name,
	    added_by_status_yet,
	    added_by_status_owned,
	    added_by_status_toplay,
	    added_by_status_dropped,
	    added_by_status_playing,
        platform_names

    from source
)

select * from renamed

```

Once you save the file, you can run 'dbt build' in the terminal in the bottom left panel. if there are not errors showing up, you will have your stg table in the dbt_database that you set up in your dbt account.

<img width="1410" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/37ad26ca-4f36-47d2-825b-692d4ae760b3">


<img width="1440" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/07f7fae9-0ff1-4411-9e07-6823c01ddc5b">

<img width="942" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/04ae50ef-785e-4bd3-98eb-29bbd74bbf8d">

Finally, once you stg table is built, you can create your dimension table sql files and your fact table sql to get your modelled data in BigQuery.  Once all your dim files and fact table are created, you need to run again 'dbt build' run to push the data into your datawarehouse.

<img width="942" alt="image" src="https://github.com/jcgarciasis/RAWG_games_analysis/assets/32393447/338e7f40-7827-4606-af72-d36564bcc251">

Finally, we need to export the modelled data from BigQuery using Google Drive option and point this csv to tableau to build the final dashboard.















   

