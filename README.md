## Getting set up
aws configure
terraform login {{terraform_api_key}} - Stored in Gitpod

### Use Data Sources to avoid hard coding availability zones


### When using the terraform console, use terraform.tfvars for variables 

### terraform data ec2 api to query available amis
```sh
# find ami on aws 
aws ec2 describe-images --image-ids ami-080e1f13689e07408
#"OwnerId": "099720109477",
#"Name": "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240301",

#"ImageLocation": "amazon/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240301",```

```
```
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
data "aws_ami" "server_ami" {
    most_recent = true
    owners = ["099720109477"]

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"] # ignore date
    } 
}

resource "aws_instance" "mtc_main" {
    instance_type = var.main_instance_type
    ami = data.aws_ami.server_ami.id
    
}
```
#### `describe-images` output
```
{
    "Images": [
        {
            "Architecture": "x86_64",
            "CreationDate": "2024-03-01T04:02:56.000Z",
            "ImageId": "ami-080e1f13689e07408",
            "ImageLocation": "amazon/ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240301",
            "ImageType": "machine",
            "Public": true,
            "OwnerId": "099720109477",
            "PlatformDetails": "Linux/UNIX",
            "UsageOperation": "RunInstances",
            "State": "available",
            "BlockDeviceMappings": [
                {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                        "DeleteOnTermination": true,
                        "SnapshotId": "snap-057fda6c9eb1d88ec",
                        "VolumeSize": 8,
                        "VolumeType": "gp2",
                        "Encrypted": false
                    }
                },
                {
                    "DeviceName": "/dev/sdb",
                    "VirtualName": "ephemeral0"
                },
                {
                    "DeviceName": "/dev/sdc",
                    "VirtualName": "ephemeral1"
                }
            ],
            "Description": "Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2024-03-01",
            "EnaSupport": true,
            "Hypervisor": "xen",
            "ImageOwnerAlias": "amazon",
            "Name": "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240301",
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SriovNetSupport": "simple",
            "VirtualizationType": "hvm",
            "BootMode": "uefi-preferred",
            "DeprecationTime": "2026-03-01T04:02:56.000Z"
        }
    ]
}
```
#### Display query 
```sh
terraform apply -auto-approve
terraform state show data.aws_ami.server_ami
```

### User data
From: https://courses.morethancertified.com/courses/1566590/lectures/35848100

```sh
terraform state list
terraform taint <resource>
```