provider "mongodbatlas" {
  public_key = "public_key" #required
  private_key  = "private_key" #required
}

resource "mongodbatlas_project_ip_whitelist" "testwhitelist" {
    project_id = var.projectid

    whitelist {
      cidr_block = "1.2.3.4/32"
      comment    = "cidr block for tf workshop"
    }
    whitelist {
      ip_address = "2.3.4.5"
      comment    = "ip address for tf workshop"
    }
    whitelist {
      cidr_block = "3.4.5.6/32"
      comment    = "cidr block for tf workshop"
    }
    whitelist {
      ip_address = "4.5.6.7"
      comment    = "ip address for tf workshop"
    }
 }
  resource "mongodbatlas_database_user" "testuser" {
    username      = "TestUser"
    password      = "Terraformrules"
    project_id    = var.projectid
    database_name = "admin"

    roles {
        role_name     = "atlasAdmin"
        database_name = "admin"
    }
}
resource "mongodbatlas_network_container" "testcontainer" {
    project_id       = var.projectid
    atlas_cidr_block = "10.8.0.0/21"
    provider_name    = "AWS"
    region_name      = "US_EAST_1"
  }
resource "mongodbatlas_cluster" "testclusterM30" {
  project_id   = var.projectid
  name         = "TerraformCluster0"
  num_shards   = 1

  replication_factor           = 3
  backup_enabled               = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.0"

  //Provider Settings "block"
  provider_name               = "AWS"
  disk_size_gb                = 100
  provider_disk_iops          = 300
  provider_volume_type        = "STANDARD"
  provider_encrypt_ebs_volume = true
  provider_instance_size_name = "M30"
  provider_region_name        = "US_EAST_1"
}
resource "mongodbatlas_cluster" "testclusterM10" {
  project_id   = var.projectid
  name         = "TerraformCluster1"
  num_shards   = 1

  replication_factor           = 3
  backup_enabled               = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "4.0"

  //Provider Settings "block"
  provider_name               = "AWS"
  disk_size_gb                = 100
  provider_disk_iops          = 300
  provider_volume_type        = "STANDARD"
  provider_encrypt_ebs_volume = true
  provider_instance_size_name = "M10"
  provider_region_name        = "US_WEST_1"
}
