variable "credentials" {
  description = "My Credentials"
  default     = "/home/juancarlosgarcia/.gc/my-creds.json"
}
variable "project" {
  description = "Project"
  default     = "iconic-indexer-412617"
}
variable "region" {
  description = "region"
  default     = "us-central1"
}
variable "location" {
  description = "Project Location"
  default     = "US"
}
variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}
variable "gcs_bucket_name" {
  description = "Bucket Storage Name"
  default     = "iconic-indexer-412617-terra-bucket"
}
variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
