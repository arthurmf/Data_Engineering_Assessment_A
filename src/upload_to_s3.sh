#!/bin/bash

# Path to the file to be uploaded
FILE_PATH=$1

# S3 bucket and path
S3_BUCKET="s3://$BUCKET_NAME/data-source/"

# Upload the file to S3
echo "Uploading '$FILE_PATH' to '$S3_BUCKET'..."
aws s3 cp "$FILE_PATH" "$S3_BUCKET"

# Check if the upload was successful
if [ $? -eq 0 ]; then
  echo "File '$FILE_PATH' successfully uploaded to '$S3_BUCKET'."
else
  echo "Error: Failed to upload '$FILE_PATH' to S3."
  exit 1
fi