# Terraform deployment files

This folder provides all the necessary files and modules to deploy the 'stage' and 'prod' environments of the NoteJam application.

## Architecture overview

![Architecture overview](https://github.com/karimodm/notejam/blob/master/Architecture%20Diagram.png)

## Requirements

- Terraform (https://www.terraform.io/downloads.html)
- Set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variable in your local environment
 

## Directory structure

In our project, we divide Terraform configuration files into three main categories:
- `modules`: All the necessary AWS building blocks: Autoscaling Groups, Docker Cluster, Load Balancer, etc. Everything has been modularized for maximum code reusability.
- `stage`: Architecture defition for the 'stage' environment.
- `prod`: Architecture defition for the 'prod' environment.

The `stage` and `prod` folders are divided into the following tiers:
- `common`: Contains those pieces of the architecture that are rarely changed, and form the base upon which all the rest of the infrastructure depends: VPC, Security Groups and such.
- `db`: Contains the definition for the database layer of the app.
- `app`: This is where the application is actually deployed as a Docker container, on top of all the pieces put in place in the other tiers.

**Why do we separate our Terraform configuration files into three categories?**

**Reason 1**: Sometimes, we don't want to touch specific part of our environments after initial creation. For example, we don't want to destroy our RDS Tables, IAM roles, or subnets. That's why we create a specific `common` tier for this scenario.

**Reason 2**: We want to deploy our application in several regions, let's say, `ap-northeast-1` a.k.a Tokyo and `ap-southeast-1` a.k.a Singapore. IAM role are global configuration which only needs to be executed one time.

**Reason 3**: For application versioning, we usually only change Docker tag version or instance's launch configuration. Therefore, we separate we keep application-specific pieces of the infrastructure in a dedicated 'app' tier.

## Deployment steps

For the first step, we need to deploy these environments in order: `common` --> `db` --> `app`. After first deployment, our changes will usually happen in `app` category, so we don't need to touch other tiers anymore.

Please note that for the `db` and `app` tiers you will need to specify the `db_user` and `db_pass` variables, corresponding to the database username and password respectively.
You can do that interactively or by specifying environment variables following the Terraform specification `TF_VAR_db_user` and `TF_VAR_db_pass`.

The workflow for each part is basically quite the same:

1. Modify configuration.tfvars variables if needed
1. Run `terraform plan` and confirm changes
1. Run `terraform apply`

## Continous Delivery

Continous Delivery integration is enabled for this application.

- The `stage` `app` tier gets deployed when a commit to the `master` branch occurs.
- The `prod` `app` tier gets deployed when a tag of the form `release-*` gets pushed.
