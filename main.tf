// Tutorial Doc: https://www.mongodb.com/developer/products/atlas/deploy-mongodb-atlas-terraform-aws/
terraform {
required_providers {
mongodbatlas = {
    source = "mongodb/mongodbatlas"
    version = "1.15.3"
    }
  }
}

provider "mongodbatlas" {
  public_key = <your-public-key> 
  private_key  = <your-private-key> 
}
resource "mongodbatlas_cluster" "test2" {
  project_id   = <your-project-id>
  name         = "cluster-test"
  num_shards   = 1

  replication_factor = 3
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "7.0"

  //Provider Settings "block"
  provider_name               = "AWS"
  provider_region_name        = "US-EAST-1"
  disk_size_gb                = 100
  provider_volume_type        = "STANDARD"
  provider_instance_size_name = "M10"
}
// Add IP Access Doc: https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project_ip_access_list
resource "mongodbatlas_network_container" "test" {
    project_id       = <your-project-id> 
    atlas_cidr_block = "10.8.0.0/21"
    provider_name    = "AWS"
    region_name = "US-EAST-1"
}

resource "mongodbatlas_project_ip_access_list" "ip_test" {
    project_id = <your-project-id> 
    ip_address = "1.2.3.4"
    comment = "ip address for tf acc testing"
}

resource "mongodbatlas_project_ip_access_list" "cidr_test" {
    project_id = <your-project-id>
    cidr_block = "2.3.4.5/32"
    comment = "cidr block for tf acc testing"
}

