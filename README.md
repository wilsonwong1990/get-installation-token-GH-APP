## get-installation-token-GH-APP

A script to get the installation token from a [GitHub App](https://developer.github.com/v3/apps/) 

[Instructions to create a GitHub App](https://developer.github.com/apps/building-github-apps/creating-a-github-app/)

When a Github App is created, you [generate a private key](https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#generating-a-private-key) which is used to generate a JSON Web Token. With that you can, query the [installation token endpoint](https://developer.github.com/v3/apps/#create-a-new-installation-token) to get a token that can be used for API calls. These tokens will expire after some time. 

This script will take your private key, generate the JWT then output an installation token for use. The script is more or less a wrapper for the ruby script that generates the JWT and then queries the [installation endpoint](https://developer.github.com/apps/building-github-apps/authenticating-with-github-apps/#authenticating-as-a-github-app) for you with it.


#### Requirements:

* ruby w/ openssl and jwt
* a GitHub App private key 

#### How to use: 

Make sure the scripts are executable and run:

```
./get-installation-token.sh
```


