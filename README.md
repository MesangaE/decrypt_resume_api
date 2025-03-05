# AWS RESUME API PROJECT
[![Deploy](https://github.com/FaithKovi/cloud-resume-api-AWS/actions/workflows/deploy.yml/badge.svg)](https://github.com/FaithKovi/cloud-resume-api-AWS/actions/workflows/deploy.yml)


This project is about creating a serverless function that fetches resume data stored in a NoSQL Database and returns it in JSON format. 

## Objective
The main objective is to create an API that can provide JSON-formatted resume data, and automate the deployment and infrastructure with Terraform 


## Stack
- <b>Serverless Function:</b> AWS Lambda
- <b>API:</b> API gateway
- <b>Infrastructure as Code:</b> Terraform 
- <b>CI/CD:</b> Github Actions 
- <b>NoSQL database:</b> DynamoDB


## Set Up
### Installation 
- Python
- Terraform
- AWS CLI (Set up your AWS profile)
- Install [gpg](https://gnupg.org/) and create passphrase


### Upload resume

<p>Upload your resume in `json` format to the `terraform` folder</p>

### Variables encryption
<p>Encrypt the <b>variables.tfvars</b> file with Symmetric encryption using gpg.</p>
Run this command;

```
$ gpg --symmetric variables.tfvars
```

### Add Secrets
<p>Add the following Action secrets to your repository:</p>

- AWS_REGION
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- BUCKET_NAME
- SECRET_PASSPHRASE





