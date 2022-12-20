variable "ibmcloud_api_key" {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Region where VPC will be created. To find your VPC region, use `ibmcloud is regions` command to find available regions."
  type        = string
  
}

variable "resource_group" {
  description = "Region where VPC will be created. To find your VPC region, use `ibmcloud is regions` command to find available regions."
  type        = string
  
}

variable "ssh_key" {
  description = "Public SSH Key for VSI creation. Must be a valid SSH key that does not already exist in the deployment region."
  type        = string
  
}

variable "tags" {
  description = "List of tags to apply to resources created by this module."
  type        = list(string)
  default     = []
}

##############################################################################


##############################################################################
# VPC Variables
##############################################################################

variable "network_cidr" {
  description = "Network CIDR for the VPC. This is used to manage network ACL rules for cluster provisioning."
  type        = string
  default     = "10.0.0.0/8"
}

variable "vpcs" {
  description = "List of VPCs to create. The first VPC in this list will always be considered the `management` VPC, and will be where the VPN Gateway is connected. VPCs names can only be a maximum of 16 characters and can only contain lowercase letters, numbers, and - characters. VPC names must begin with a lowercase letter and end with a lowercase letter or number."
  type        = list(string)
  default     = ["management", "workload"]

  validation {
    error_message = "VPCs names can only be a maximum of 16 characters and can only contain lowercase letters, numbers, and - characters. Names must also begin with a lowercase letter and end with a lowercase letter or number."
    condition = length([
      for name in var.vpcs :
      name if length(name) > 16 || !can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])$", name))
    ]) == 0
  }
}

variable "enable_transit_gateway" {
  description = "Create transit gateway"
  type        = bool
  default     = true
}

##############################################################################
# Virtual Server Variables
##############################################################################

variable "vsi_image_name" {
  description = "VSI image name. Use the IBM Cloud CLI command `ibmcloud is images` to see availabled images."
  type        = string
  default     = "ibm-ubuntu-18-04-6-minimal-amd64-2"
}

variable "vsi_instance_profile" {
  description = "VSI image profile. Use the IBM Cloud CLI command `ibmcloud is instance-profiles` to see available image profiles."
  type        = string
  default     = "cx2-4x8"
}

variable "vsi_per_subnet" {
  description = "Number of Virtual Servers to create on each VSI subnet."
  type        = number
  default     = 1
}

##############################################################################




