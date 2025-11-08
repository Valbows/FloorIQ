#!/bin/bash
# Smoke-test ATTOM Property API endpoints

set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | grep ATTOM | xargs)
fi

if [ -z "$ATTOM_API_KEY" ]; then
  echo "❌ ATTOM_API_KEY missing from environment"
  exit 1
fi

BASE_URL="https://api.gateway.attomdata.com/propertyapi/v1.0.0"
ADDRESS1="1600 Amphitheatre Pkwy"
ZIP="94043"

echo "📍 Base URL: $BASE_URL"
echo "🔑 API Key Prefix: ${ATTOM_API_KEY:0:8}..."
echo ""

echo "Step 1: Address lookup"
curl -s -G "$BASE_URL/property/address" \
  --data-urlencode "address1=$ADDRESS1" \
  --data-urlencode "postalcode=$ZIP" \
  -H "apikey: $ATTOM_API_KEY" \
  -H "Accept: application/json" | head -40

echo "\n---"

ATTOM_ID=$(curl -s -G "$BASE_URL/property/address" \
  --data-urlencode "address1=$ADDRESS1" \
  --data-urlencode "postalcode=$ZIP" \
  -H "apikey: $ATTOM_API_KEY" \
  -H "Accept: application/json" | python3 -c "import sys,json; data=json.load(sys.stdin); props=data.get('property') or []; print(props[0].get('identifier',{}).get('attomId','')) if props else ''" 2>/dev/null || echo "")

if [ -n "$ATTOM_ID" ]; then
  echo "📦 ATTOM ID: $ATTOM_ID"
  echo "\nStep 2: Property detail"
  curl -s -G "$BASE_URL/property/detail" \
    --data-urlencode "attomid=$ATTOM_ID" \
    -H "apikey: $ATTOM_API_KEY" \
    -H "Accept: application/json" | head -40
else
  echo "⚠️  No ATTOM ID returned from address lookup"
fi

echo "\n---"

if [ -n "$ATTOM_ID" ]; then
  echo "Step 3: Comparable sales"
  curl -s -G "$BASE_URL/property/detail/comparable" \
    --data-urlencode "attomid=$ATTOM_ID" \
    --data-urlencode "distance=1" \
    --data-urlencode "propertytype=RES" \
    --data-urlencode "sortby=Distance" \
    --data-urlencode "page=1" \
    --data-urlencode "pagesize=5" \
    -H "apikey: $ATTOM_API_KEY" \
    -H "Accept: application/json" | head -40
fi
