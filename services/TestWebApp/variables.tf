#export ARM_ACCESS_KEY="$(az storage account keys list --resource-group terraform_storage --account-name denheenj | grep -m 1 -Eo 'value.{92}' | grep -Eo ".{88}$")"

variable "AzureSubID" {
   default = "081ebe4e-ca78-4a93-a1f9-e8f4756a7deb"
}

variable "AzureTennantID" {
   default = "f4f6dcd1-23d7-4ff4-bc6c-150f1b5db3cc"
}

variable "PUB_KEY" {}
