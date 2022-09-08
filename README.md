# Porkbun DDNS Bash

Porkbun Dynamic DNS bash script for keeping DNS record up-to-date with system IP address. Supports IPv4 or IPv6, only modifies the record if necessary, and creates the record if it does not exist.

## Configure
Open the `porkbun-ddns.sh` file in your editor of choice to modify the configuration options.

### API Key
A Porkbun API key is required for the script to function.

#### Enable API Access
Enable `API ACCESS` for your domain of choice.

+ Navigate to the Porkbun [Domain Management](https://porkbun.com/account/domainsSpeedy) panel.
+ Next to your domain, select `Details` to expand domain settings.
+ Enable the `API ACCESS` radio toggle.

#### Generate API Key
Generate a new API key to use in the script.

+ Navigate to the Porkbun [API Access](https://porkbun.com/account/api) panel.
+ Enter an `API Key Title` and select `Create API Key`.
+ Copy the generated key values to the `porkbun-ddns.sh` variables.

```bash
declare APIKEY="pk1_generated_api_key"
declare APIKEYSECRET="sk1_generated_secret_key"
```

### Domain
The root domain or a subdomain can be used for the dynamic DNS record. To use the root domain, leave the `SUBDOMAIN` variable empty.

```bash
# Set ddns.example.com to system IP
declare -l DOMAIN="example.com"
declare -l SUBDOMAIN="ddns"

# Set example.com to system IP
declare -l DOMAIN="example.com"
declare -l SUBDOMAIN=""
```

### RECORD
IP version and Time-To-Live values can be modified to suit your application. By default, the script will use IPv4 (A), and 6 minutes TTL (360).

### Example

```bash
# Configuration
# =============
# API Key - "pk1_ex"
declare APIKEY="pk1_generated_api_key"
# Secret API Key - "sk1_ex"
declare APIKEYSECRET="sk1_generated_secret_key"
# Domain - "example.com"
declare -l DOMAIN="example.com"
# Subdomain - "" || "www" || "*"
declare -l SUBDOMAIN=""
# Record - "A" || "AAAA"
declare -u RECORD="A"
# Record TTL - "360" || "600"
declare -i RECORDTTL="360"
```

## Cronjob
Setup a CronJob to keep the DNS record accurate. Use `crontab -e` to add job.

```bash
*/10 * * * * /path/to/porkbun-ddns.sh
```

## License
Porkbun DDNS Bash is distributed under the [ISC License](https://gitlab.com/whateverbits/porkbun-ddns-bash/-/blob/main/LICENSE).

Porkbun is a registered trademark of [Porkbun LLC](https://porkbun.com/).
