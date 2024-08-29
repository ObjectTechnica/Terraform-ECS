//The backend configuration is loaded by Terraform extremely early, before
//the core of Terraform can be initialized. This is necessary because the backend
//dictates the behavior of that core. The core is what handles interpolation
//processing. Because of this, interpolations cannot be used in backend
//configuration.
terraform {
  backend "s3" {
    bucket = "NameOfS3Bucket-remote-state"
    key    = "ecs/remote_state"
    region = "us-west-2"
  }
}
