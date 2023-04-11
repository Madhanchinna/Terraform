terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-east-2"
}

	resource "aws_s3_bucket" "s3_bucket" {
	  bucket = var.bucket_name
	
	  tags = var.tags
	}
	
	resource "aws_s3_bucket_website_configuration" "s3_bucket" {
	  bucket = aws_s3_bucket.s3_bucket.id
	
	  index_document {
	    suffix = "index.html"
	  }
	
	  error_document {
	    key = "error.html"
	  }
	}
	
	resource "aws_s3_bucket_acl" "s3_bucket" {
	  bucket = aws_s3_bucket.s3_bucket.id
	
	  acl = "public-read"
	}
	
	resource "aws_s3_bucket_policy" "s3_bucket" {
	  bucket = aws_s3_bucket.s3_bucket.id
	
	  policy = jsonencode({
	    Version = "2012-10-17"
	    Statement = [
	      {
	        Sid       = "PublicReadGetObject"
	        Effect    = "Allow"
	        Principal = "*"
	        Action    = "s3:GetObject"
	        Resource = [
	          aws_s3_bucket.s3_bucket.arn,
	          "${aws_s3_bucket.s3_bucket.arn}/*",
	        ]
	      },
	    ]
	  })
	}
