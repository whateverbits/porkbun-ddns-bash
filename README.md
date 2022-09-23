# Porkbun DDNS Bash
Porkbun Dynamic DNS Bash script for keeping a DNS record up-to-date with the system IP address. Supports IPv4 and/or IPv6, only modifies the record if necessary, and does not modify any record configurations besides IP address. Record must already exist on Porkbun for script to function.

## Configure
Open the `porkbun-ddns.sh` file in your editor of choice to modify the configuration options.

### API Key
A Porkbun API key is required for the script to function.

Enable `API ACCESS` for your domain.

+ Navigate to the [Porkbun Domain Management](https://porkbun.com/account/domainsSpeedy) panel.
+ Next to your domain, select `Details` to expand domain settings.
+ Enable the `API ACCESS` radio toggle.

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
declare -l DOMAIN="example.com"
declare -l SUBDOMAIN="ddns"
```

### Records
Toggle A (IPv4) and/or AAAA (IPv6) record updates.

```bash
declare -l A_RECORD="true"
declare -l AAAA_RECORD="false"
```

### Example

```bash
# Configuration
# =============
# Porkbun API Key
declare APIKEY="pk1_generated_api_key"
# Porkbun API Key Secret
declare APIKEYSECRET="sk1_generated_secret_key"
# Domain: "example.com"
declare -l DOMAIN="example.com"
# Subdomain: "" || "www"
declare -l SUBDOMAIN="ddns"
# IPv4 A Record: "true" || "false"
declare -l A_RECORD="true"
# IPv6 AAAA Record: "true" || "false"
declare -l AAAA_RECORD="false"
```

## Cronjob
Setup a CronJob to keep the DNS record accurate. Use `crontab -e` to add job.
Verify the `porkbun-ddns.sh` file has execute permissions: `chmod 750 porkbun-ddns.sh`.

```bash
# Every 10 minutes
*/10 * * * * /path/to/porkbun-ddns.sh
```

## Issues
Open new issues in the [GitLab Issue Tracker](https://gitlab.com/whateverbits/porkbun-ddns-bash/-/issues).

## License
Porkbun DDNS Bash is distributed under the [ISC License](https://gitlab.com/whateverbits/porkbun-ddns-bash/-/blob/main/LICENSE).

Porkbun is a registered trademark of [Porkbun LLC](https://porkbun.com/).
