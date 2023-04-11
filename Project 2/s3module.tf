module "website_s3_bucket" {
  source = "./modules/aws-s3-static-website-bucket"

  bucket_name = "module-sss-terraform"

  tags = {
    Terraform   = "true"
    Youtube  = "web_site"
  }
}