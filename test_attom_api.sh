#!/bin/bash

# ATTOM API Integration Test
# Tests API key authentication and basic property search

set -e

echo "=================================="
echo "ATTOM API Integration Test"
echo "=================================="
echo ""

# Load credentials from .env
if [ -f .env ]; then
    export $(grep -v '^#' .env | grep ATTOM | xargs)
fi

# Verify credentials are set
if [ -z "$ATTOM_API_KEY" ]; then
    echo "❌ ERROR: ATTOM_API_KEY not found in .env"
    exit 1
fi

BASE_URL="https://api.gateway.attomdata.com/propertyapi/v1.0.0"

echo "📍 API URL: $BASE_URL"
echo "🔑 API Key: ${ATTOM_API_KEY:0:8}..."
echo ""

TEST_ADDRESS="1600 Amphitheatre Pkwy"
TEST_ZIP="94043"

# Step 1: Query address endpoint
echo "Step 1: Requesting address lookup..."
ADDRESS_URL="$BASE_URL/property/address"

ADDRESS_RESPONSE=$(curl -s -w "\nHTTP_STATUS:%{http_code}" \
  -G "$ADDRESS_URL" \
  --data-urlencode "address1=$TEST_ADDRESS" \
  --data-urlencode "postalcode=$TEST_ZIP" \
  -H "apikey: $ATTOM_API_KEY" \
  -H "Accept: application/json")

HTTP_STATUS=$(echo "$ADDRESS_RESPONSE" | grep HTTP_STATUS | cut -d: -f2)
ADDRESS_BODY=$(echo "$ADDRESS_RESPONSE" | sed '/HTTP_STATUS/d')

if [ "$HTTP_STATUS" != "200" ]; then
    echo "❌ Address lookup FAILED"
    echo "HTTP Status: $HTTP_STATUS"
    echo "Response: $ADDRESS_BODY"
    exit 1
fi

echo "✅ Address lookup SUCCESS"
echo ""
echo "Response Preview:"
echo "$ADDRESS_BODY" | head -20
echo ""

PROPERTY_ID=$(echo "$ADDRESS_BODY" | python3 -c "import sys, json; data=json.load(sys.stdin); props=data.get('property') or []; print(props[0].get('identifier', {}).get('attomId', '')) if props else ''" 2>/dev/null || echo "")

if [ -n "$PROPERTY_ID" ]; then
    echo "📋 Found ATTOM ID: $PROPERTY_ID"
    echo ""

    # Step 2: Fetch property details
    echo "Step 2: Fetching property details..."
    DETAILS_URL="$BASE_URL/property/detail"

    DETAILS_RESPONSE=$(curl -s -w "\nHTTP_STATUS:%{http_code}" \
      -G "$DETAILS_URL" \
      --data-urlencode "attomid=$PROPERTY_ID" \
      -H "apikey: $ATTOM_API_KEY" \
      -H "Accept: application/json")

    HTTP_STATUS=$(echo "$DETAILS_RESPONSE" | grep HTTP_STATUS | cut -d: -f2)
    DETAILS_BODY=$(echo "$DETAILS_RESPONSE" | sed '/HTTP_STATUS/d')

    if [ "$HTTP_STATUS" != "200" ]; then
        echo "❌ Property details FAILED"
        echo "HTTP Status: $HTTP_STATUS"
        echo "Response: $DETAILS_BODY"
        exit 1
    fi

    echo "✅ Property details SUCCESS"
    echo ""
    echo "Response Preview:"
    echo "$DETAILS_BODY" | head -20
    echo ""
else
    echo "⚠️  No ATTOM ID returned from address lookup"
fi

# Summary
echo "=================================="
echo "✅ ALL TESTS PASSED"
echo "=================================="
echo ""
echo "ATTOM API is accessible and responding correctly."
echo "Address lookup: ✅"
[ -n "$PROPERTY_ID" ] && echo "Property details: ✅"
echo ""
echo "The API key is working correctly!"
