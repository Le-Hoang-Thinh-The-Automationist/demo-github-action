#!/usr/bin/env bash
DEFAULT_ADDRESS="${CONTAINER_IP:-localhost}"
DEFAULT_PORT="${CONTAINER_PORT:-8080}"

URL="http://$DEFAULT_ADDRESS:$DEFAULT_PORT/check"

# -w "\n%{http_code}" appends the code on a new line
response=$(curl -s -w "\n%{http_code}" "$URL")
body=$(head -n -1 <<<"$response")
code=$(tail -n1 <<<"$response")

echo "DEFAULT_ADDRESS: $DEFAULT_ADDRESS"
echo "DEFAULT_PORT: $DEFAULT_PORT"
echo "==================="

echo "HTTP Status: $code"
echo "Response Body:"
echo "$body"
