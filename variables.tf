variable "minio_server" {
  type        = string
  description = "Adresse du serveur MinIO"
}

variable "minio_user" {
  type        = string
  description = "Nom d'utilisateur MinIO"
}

variable "minio_password" {
  type        = string
  description = "Mot de passe MinIO"
  sensitive   = true
}

variable "bucket_name" {
  type        = string
  description = "Nom du bucket à créer"
}
