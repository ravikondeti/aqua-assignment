terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.66.0"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }    
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
    random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }    
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }  
     tls = {
      source  = "hashicorp/tls"
      version = ">= 3.1"
    }      
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "aqua-assignment-remotestate-files"
    key    = "inframodule.tf"
    region = "ap-south-1"
    dynamodb_table = "aqua-inframodule-remote-tfstate" 
  }  
}

