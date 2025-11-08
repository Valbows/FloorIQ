#!/bin/bash

set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | grep ATTOM | xargs)
fi

if [ -z "$ATTOM_API_KEY" ]; then
  echo "❌ ATTOM_API_KEY missing from environment"
  exit 1
fi

BASE_URL="https://api.gateway.attomdata.com/propertyapi/v1.0.0"
ADDRESS="1600 Amphitheatre Pkwy"
ZIP="94043"

echo "Testing ATTOM property address endpoint variations..."
echo ""

# ATTOM supports specific query combinations; try a few relevant permutations
declare -A QUERIES=(
  ["address+zip"]="address1=$ADDRESS&postalcode=$ZIP"
  ["address+city+state"]="address1=$ADDRESS&city=Mountain%20View&state=CA"
)

for label in "${!QUERIES[@]}"; do
  query=${QUERIES[$label]}
  echo "Testing combination: $label"
  HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -G "$BASE_URL/property/address" \
    --data "$query" \
    -H "apikey: $ATTOM_API_KEY" \
    -H "Accept: application/json")
  echo "HTTP Status: $HTTP_CODE"
  echo ""
done
