#!/bin/sh
echo off
token=$(jq -r ".token" token.json)

#step 1 - Use Mavenlink API to trigger temporary AWS S3 Authentication
file="skills.csv"
attachment=$(curl -H -s "Authorization: Bearer $token" --form "direct=true" --form "attachment[filename]=$file" --form "attachment[type]=post_attachment" "https://api.mavenlink.com/api/v1/attachments.json")

awsKey=$(jq -n "$attachment" | jq -r '.fields.AWSAccessKeyId')
key=$(jq -n "$attachment" | jq -r '.fields.key')
policy=$(jq -n "$attachment" | jq -r '.fields.policy')
sig=$(jq -n "$attachment" | jq -r '.fields.signature')
url=$(jq -n "$attachment" | jq -r '.action')
id=$(jq -n "$attachment" | jq -r '.id')


#step 2 - Upload to AWS bucket
curl -X POST \
  "$url" \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'AWSAccessKeyId='$awsKey \
  -F "Content-Disposition=attachment; filename=\"$file\"; filename*=UTF-8''"$file \
  -F 'x-amz-server-side-encryption=AES256' \
  -F 'key='$key \
  -F 'policy='$policy \
  -F 'signature='$sig \
  -F 'acl=private' \
  -F 'success_action_status=201' \
  -F 'utf8=✓' \
  -F 'file=@'$file

#Step 3 - Marks an upload as complete, and verifies its existence on the CDN
curl -X -s PUT -H "Authorization: Bearer $token" "https://api.mavenlink.com/api/v1/attachments/$id/sync" | jq >> "attachment-log.txt"

echo "#######################"
echo ""
echo "See the attachment-log.txt file for details. Use the ID from the JSON response to attach the uploaded file to a post or expense."
