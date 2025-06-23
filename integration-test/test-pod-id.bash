#!/usr/bin/env bash
DEFAULT_ADDRESS="${POSTGRES_IP:-localhost}"
DEFAULT_PORT="${POSTGRES_PORT:-8080}"

URL="http://$DEFAULT_ADDRESS:$DEFAULT_PORT/"

# -w "\n%{http_code}" appends the code on a new line
response=$(curl -s -w "\n%{http_code}" "$URL")
body=$(head -n -1 <<<"$response")
code=$(tail -n1 <<<"$response")

echo "HTTP Status: $code"
echo "Response Body:"
echo "$body"
