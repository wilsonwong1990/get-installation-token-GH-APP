#!/bin/bash
rm pem_dir.txt
rm GHE.pem
rm jwt.txt
echo "Where is the GitHub APP certificate? (.pem format)"

read pem_path

echo "What is the installation id? You can find it in settings of the GitHub App"

read installation_id

cat $pem_path >> GHE.pem

ruby ./generate_token_gh_app.rb

jwt=$(cat jwt.txt)

curl -i -X POST \
-H "Authorization: Bearer $jwt" \
-H "Accept: application/vnd.github.machine-man-preview+json" \
https://api.github.com/app/installations/$installation_id/access_tokens
