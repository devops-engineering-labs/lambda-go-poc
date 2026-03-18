# lambda-go-poc

## 📌 Overview

This project is a **Proof of Concept (PoC)** for building and deploying
AWS Lambda functions using **Go (Golang)**.

The goal is to provide a simple, lightweight, and efficient example of:

-   Building Lambda functions in Go
-   Running locally for development
-   Deploying to AWS
-   Integrating with AWS services (e.g., S3, SSM, Secrets Manager)

------------------------------------------------------------------------

## 🎯 Purpose

This repository is intended to:

-   Validate Go as a runtime for AWS Lambda
-   Serve as a reference implementation for future serverless services
-   Provide a minimal and clean setup for fast development

------------------------------------------------------------------------

## 🧱 Project Structure

    .
    ├── infra/                           
    ├── pkg/                
    ├── main.go             
    ├── go.mod
    ├── go.sum
    └── README.md

------------------------------------------------------------------------

## ⚙️ Requirements

-   Go \>= 1.20
-   AWS CLI configured
-   Terraform (optional)

------------------------------------------------------------------------

## 🚀 Running Locally

``` bash
git clone <repo-url>
cd lambda-go-poc
go mod tidy
go run main.go
```

------------------------------------------------------------------------

## 🧪 Build for AWS Lambda

``` bash
GOOS=linux GOARCH=amd64 go build -o bootstrap main.go
```

ARM:

``` bash
GOOS=linux GOARCH=arm64 go build -o bootstrap main.go
```

------------------------------------------------------------------------

## 📦 Deploy

``` bash
zip function.zip bootstrap

aws lambda update-function-code \
  --function-name <function-name> \
  --zip-file fileb://function.zip
```

------------------------------------------------------------------------

## 🔐 Configuration

-   SSM Parameter Store
-   Secrets Manager
-   Environment variables

------------------------------------------------------------------------

## 📊 Observability

-   CloudWatch Logs (default)
-   No external APM (cost optimization)

------------------------------------------------------------------------

## 🏗️ Infrastructure

``` bash
terraform init
terraform plan
terraform apply
```

------------------------------------------------------------------------

## 🧼 Cleanup

``` bash
terraform destroy
```

------------------------------------------------------------------------

## 📌 Notes

-   PoC project
-   Keep it simple
-   Follow least privilege

------------------------------------------------------------------------
