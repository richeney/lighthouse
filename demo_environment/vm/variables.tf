variable "resource_group" {}

variable "subnet_id" {}

variable "name" {
    default = "myVM"
}

variable "names" {
    type    = list
    default = []
}
