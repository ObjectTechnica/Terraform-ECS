# AWS / Elastic-Container-Service #
### What does all this do? ###
This terraform stack will deploy the infrastructure for a microservices/docker/container style architecture based on AWS ECS resources.  This includes the below resources.  The ecs and redis cluser size can be adjusted to be cost effective.
* 1x VPC
* 6x subnets
    * 1 per AZ based on US-West-2)
* 1x Internet Gateway
    *  Attached to 3x subnets identified as public
* 3x NAT Gateways
    * Attached to 3x subnets identified as private
* 1x Auto Scaling Group for ECS Compute nodes
* 1x Launch configuration for bootstrapping ECS compute nodes
* 1x ec2 Bastion Node
* 3x Security groups
    * One for the Bastion Node or "JumpHost"
    * One for the ECS Compute nodes
    * One for Redis cluster
* 1x Elasticache cluster (redis)
    * X node Shard spread across AZ's based on US-West-2
    * Automatic_failover Yes|No
* 1X Elastic Container Services Cluster "ECS"
    * X number of nodes defined by autoaclaing group
    * Autoscaling up-policy with cloudwatch alert
    * Autoscaling down-policy with cloudwatch alert
    * IAM profiles that allow the ecs service the ability to manage related aws resources.

### What do I need to do first? ###
Open the "variables.tf" file and update the following sections with data pertaining to your deployment.
* VPC
* VPC_CIDR
* VPC_SPREAD
* Private_Subnets
* Public_Subnets
* Bastion_Node
* Cache_Cluster
* ECS_Cluster

### What is remote state? ###
By default, Terraform stores state locally in a file named "terraform.tfstate". Because this file must exist, it makes working with Terraform in a team complicated since it is a frequent source of merge conflicts. Remote state helps alleviate these issues.

With remote state, Terraform stores the state in a remote store. Terraform supports storing state in Terraform Enterprise, Consul, S3, and more.  Remote state is a feature of backends.  Configuring and using backends is easy and you can get started with remote state quickly.  If you want to migrate back to using local state, backends make that easy as well.

### What do I do with the "states.tf" file? ###
The backend configuration (states.tf) is loaded by Terraform extremely early, before the core of Terraform can be initialized. This is necessary because the backend dictates the behavior of that core. The core is what handles interpolation processing. Because of this, interpolations cannot be used in backend configuration.  

This means that its difficult to use variables in the states.tf file.  So you will need to explicitly call out your variables in this file and not in the variables.tf.  They are

* bucket - the name of the S3 bucket with will store your remote state
* Key - the unique key string to identify your state information from other state data.
* Region - the aws region where you bucket is located.

### What do I do next? ###
Once you have all your variables populated we are going to run three commands.
* Terraform init - This will initialize a Terraform working directory.  You also must also be in the Terraform working directory for this to work properly.  Example Below...
> Terraform has been successfully initialized!
You may now begin working with Terraform. Try running "Terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.  If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other commands will detect it and
remind you to do so if necessary.

* Terraform plan - This essentially performs a dry run of your terrafom, and generates sample output based on your provisioners.  Terraform provisioners are used to execute scripts on a local or remote machine as part of resource creation or destruction. Provisioners can be used to bootstrap a resource, cleanup before destroy, run configuration management, etc.  Example Below...
>  Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

* Terraform apply -  Builds or changes real infrastructure based on your "plan"  PLEASE USE CAUTION.  Example Below...
> An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
> "+ create"
> Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.
> Enter a value:

### Whats with all this output? ###
The output that scrolls your window/terminal is whats actually happening during the Terraform apply phase.  At the end of a successful "apply" you will see two new files 1) Terraform.tfstate and 2) Terraform.tfstate.backup - ITS VERY IMPORTANT that you keep and maintain the integrity of these files.  If Terraform apply failed with an error, read the error message and fix the error that occurred. At this stage, it is likely to be a syntax error in the configuration.  At the very end of a successful apply you will get the account id of your new linked account.  Make sure you grab that information for future use.

### Any special features? ###
Yes!  If you would like to make any part of this snippet interactive, simply remove the "default = " entry from one or more variables.  The user running the apply will then be prompted for input.

### Contribution guidelines ###

* Please fork us.
* Please fork yourself.

