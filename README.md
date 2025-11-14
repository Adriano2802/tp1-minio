# TP1 --- MinIO & OpenTofu (Terraform)

### Logiciels nécessaires

-   **MinIO** (binaire `minio.exe`)
-   **OpenTofu** (`tofu`)
-   **PowerShell** / Terminal

### Fichiers requis dans le dossier

    main.tf
    variables.tf
    terraform.tfvars
    index.html
    style.css

------------------------------------------------------------------------

## 1. Lancer MinIO

    ./minio.exe server minio-data --console-address ":9001"


MinIO démarre alors sur :

http://127.0.0.1:9000

http://127.0.0.1:9001

------------------------------------------------------------------------

## ️ 2. Configuration OpenTofu

### Fichier `variables.tf`

``` hcl
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
```

###  Fichier `terraform.tfvars`

``` hcl
minio_server   = "127.0.0.1:9000"
minio_user     = "minioadmin"
minio_password = "minioadmin"
bucket_name    = "webbucket"
```

### Fichier `main.tf`

``` hcl
terraform {
  required_providers {
    minio = {
      source  = "terraform-provider-minio/minio"
      version = "3.1.0"
    }
  }
}

provider "minio" {
  minio_server   = var.minio_server
  minio_user     = var.minio_user
  minio_password = var.minio_password
  minio_ssl      = false
}

resource "minio_s3_bucket" "web_bucket" {
  bucket = var.bucket_name
}

resource "minio_s3_object" "index_html" {
  bucket_name = var.bucket_name
  object_name = "index.html"
  source      = "index.html"
}

resource "minio_s3_object" "style_css" {
  bucket_name = var.bucket_name
  object_name = "style.css"
  source      = "style.css"
}
```

------------------------------------------------------------------------

##  3. Initialiser OpenTofu


    tofu init


------------------------------------------------------------------------

##  4. Vérifier le plan


    tofu plan


------------------------------------------------------------------------

## 🚨 5. Déployer

    tofu apply


Puis taper :

    yes

Résultat :

- Bucket créé

- Fichiers uploadés

------------------------------------------------------------------------

## ️ 6. Détruire l'infrastructure


    tofu destroy


------------------------------------------------------------------------

## 🎉 Résultat final

Ton bucket **webbucket** apparaît dans la console MinIO :

http://127.0.0.1:9001

Avec les fichiers :

-   `index.html`
-   `style.css`
