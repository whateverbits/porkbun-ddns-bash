#!/bin/bash
# Porkbun DDNS Bash

# Configuration
# =============
# API Key - "pk1_ex"
declare APIKEY=""
# Secret API Key - "sk1_ex"
declare APIKEYSECRET=""
# Domain - "example.com"
declare -l DOMAIN=""
# Subdomain - "" || "www" || "*"
declare -l SUBDOMAIN=""
# Record - "A" || "AAAA"
declare -u RECORD="A"
# Record TTL - "600"
declare -i RECORDTTL="600"
# cURL
declare CURL=$(which curl)

# Porkbun API
porkbun_api() {
  declare APIURI="https://porkbun.com/api/json/v3"
  declare APIREQ="$1"
  declare APIDATA="$2"
  
  case "$APIDATA" in
    "") ;;
    *) APIDATA=", $APIDATA";;
  esac

  declare APICURL=$(
    "$CURL" -f -q -s "$APIURI/$APIREQ" \
    -H "Content-Type: application/json" \
    --data "{ \"apikey\": \"$APIKEY\", \"secretapikey\": \"$APIKEYSECRET\"$APIDATA }"
  )
  # Error
  if [ -z "$APICURL" ]; then
    echo "Unable to read $APIURI/$APIREQ"
    return 2
  fi

  echo "$APICURL"
  return 0
}

# System IP
system_ip() {
  declare API4="https://api.ipify.org"
  declare API6="https://api64.ipify.org"
  declare API
  declare SYSIP

  case "$RECORD" in
    A) API=$API4;;
    *) API=$API6;;
  esac
  
  SYSIP=$("$CURL" -f -q -s "$API")

  echo "$SYSIP"
  return 0
}

# Porkbun DDNS
porkbun_ddns() {
  declare TYPE
  declare PORKIP
  declare SYSIP

  case "$SUBDOMAIN" in
    "") TYPE="$RECORD";;
    *) TYPE="$RECORD/$SUBDOMAIN";;
  esac

  PORKIP=$(porkbun_api "dns/retrieveByNameType/$DOMAIN/$TYPE" \
  | grep -o -P '(?<="content":")[^"]+')
  SYSIP=$(system_ip)

  case "$SYSIP" in
    "") echo "Unable to fetch public IP - check internet connection." && return 2;;
    $PORKIP) echo "Porkbun DNS entry already up-to-date." && return 0;;
  esac

  case "$PORKIP" in
    "")
      porkbun_api "dns/create/$DOMAIN" \
      "\"name\": \"$SUBDOMAIN\", \"type\": \"$RECORD\", \"content\": \"$SYSIP\", \"ttl\": \"$RECORDTTL\""
      ;;
    *)
      porkbun_api "dns/editByNameType/$DOMAIN/$TYPE" \
      "\"content\": \"$SYSIP\", \"ttl\": \"$RECORDTTL\""
      ;;
  esac

  return 0
}

porkbun_ddns

unset APIKEY APIKEYSECRET DOMAIN RECORD RECORDTTL APIURI CURL
