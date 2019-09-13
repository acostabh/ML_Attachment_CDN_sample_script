#!/bin/sh
echo off
token=$(jq -r ".token" token.json)

file="skills.csv"
attachment=$(curl -H "Authorization: Bearer $token" --form "direct=true" --form "attachment[filename]=$file" --form "attachment[type]=post_attachment" "https://api.mavenlink.com/api/v1/attachments.json")

awsKey=$(jq -n "$attachment" | jq -r '.fields.AWSAccessKeyId')
key=$(jq -n "$attachment" | jq -r '.fields.key')
policy=$(jq -n "$attachment" | jq -r '.fields.policy')
sig=$(jq -n "$attachment" | jq -r '.fields.signature')
url=$(jq -n "$attachment" | jq -r '.action')




curl -X POST \
  "$url" \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'AWSAccessKeyId='$awsKey \
  -F 'content-disposition=attachment;filename="'$file'";filename*=UTF-8\''\'''$file \
  -F 'key='$key \
  -F 'policy='$policy \
  -F 'signature='$sig \
  -F 'acl=private' \
  -F 'success_action_status=201' \
  -F 'utf8=✓' \
  -F 'file=@'$file
