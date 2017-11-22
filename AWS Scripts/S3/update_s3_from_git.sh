#!/bin/bash
set -o xtrace

# Refresh Amazon CDN bucket
src=$1
bucket=$2
region=$3

aws s3api create-bucket --acl public-read --bucket $bucket --region $region --create-bucket-configuration LocationConstraint=$region

policy="{\"Statement\":[{\"Sid\":\"AddPerm\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::${bucket}/*\"}]}"
aws s3api put-bucket-policy --bucket $bucket --policy $policy

aws s3 sync $src s3://$bucket/ --exclude "*.git/*" --exclude "*.svn/*"

aws s3 website s3://$bucket/ --index-document index.html

#aws s3 rm s3://$bucket/ --recursive
#aws s3 cp . s3://$bucket/ --exclude ".git/*" --recursive

