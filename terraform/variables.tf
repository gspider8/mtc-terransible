variable "vpc_cidr" {
  type    = string
  default = "10.124.0.0/16"
}

variable "access_ip" {
  type    = string
  # my ip 99.61.91.234
  default = "99.61.91.234/32" 
}

# compute.tf

variable main_instance_type {
  type = string
  default = "t2.micro"
}

variable main_vol_size {
  type = number
  default = 8 #GB
}

variable main_instance_count {
  type = number
  default = 1
}

variable key_name {
  type = string
}

variable public_key_path {
  type = string
}