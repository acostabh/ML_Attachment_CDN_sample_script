#!/bin/sh
echo off
token=$(jq -r ".token" token.json)

file="skills.csv"
attachment=$(curl -s -H "Authorization: Bearer $token" --form "direct=true" --form "attachment[filename]=$file" --form "attachment[type]=post_attachment" "https://api.mavenlink.com/api/v1/attachments.json")

awsKey=$(jq -n "$attachment" | jq -r '.fields.AWSAccessKeyId')
key=$(jq -n "$attachment" | jq -r '.fields.key')
policy=$(jq -n "$attachment" | jq -r '.fields.policy')
sig=$(jq -n "$attachment" | jq -r '.fields.signature')
url=$(jq -n "$attachment" | jq -r '.action')


curl -X POST -H 'Cache-Control: no-cache' --form "AWSAccessKeyId=$awsKey" --form "key=$key" --form "policy=$policy" --form "signature=$sig" --form "attachment; filename=$file;" --form "acl=private" --form "success_action_status=201" --form "utf8=✓" --form "file=@$file" "$url"
