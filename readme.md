# Using make to wrap imperative boostraping commands
`brew install make`

## Setup

1. Ensure dependencys are installed and docker is running
```
make dependencies
```
2. Create local cluster
```
make create-cluster
```
3. Create github access token
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens

4. Boostrap Atlantis and Cloudflare tunnels.
    insert your github username, token from 3rd step and define a webhook secret
```
make bootstrap-atlantis
```
The terraform script will output kubectl command examples to find your public cloudflare url

5. Add the exposed atlantis url to your github project webhooks

    Go to your GitHub repository.

    Navigate to Settings > Webhooks > Add Webhook.
    
    Set the following:

    Payload URL: https://<your_cloudflare_tunnel_dns_from_cloudflared_logs>/events

    Content type: application/json

    Secret: Use the same secret as in github.secret in `atlantis-terraform/atlantis-helm-values.yaml` (defined in 4th step while bootstrapping)

    Which events to trigger: Select "Let me select individual events" and choose Pull requests and Pushes.
