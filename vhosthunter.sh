#!/bin/bash

# Function to print usage
print_usage() {
    echo "Usage: $0 <target_domain> <wordlist> [-ip target_ip] [-fs filter_size] [-fc filter_code] [-fw filter_word] [-o output_file]"
    echo "  -ip target_ip         Specify target IP address for testing with Host header"
    echo "  -fs filter_size       Filter responses by size (comma-separated for multiple sizes)"
    echo "  -fc filter_code       Filter responses by HTTP status code (comma-separated for multiple codes)"
    echo "  -fw filter_word       Filter responses by word count (comma-separated for multiple counts)"
    echo "  -o output_file        Save results to the specified file"
}

# Check if ffuf is installed
if ! command -v ffuf &> /dev/null; then
    echo "ffuf could not be found. Please install ffuf to use this script."
    exit 1
fi

# Check if at least two arguments are provided
if [ "$#" -lt 2 ]; then
    print_usage
    exit 1
fi

# Parse the mandatory arguments
TARGET_DOMAIN=$1
WORDLIST=$2

# Initialize optional arguments
TARGET_IP=""
FILTER_SIZE=""
FILTER_CODE="301,302"
FILTER_WORD=""
OUTPUT_FILE=""

# Parse the optional arguments
shift 2
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -ip)
            TARGET_IP=$2
            shift
            ;;
        -fs)
            FILTER_SIZE=$2
            shift
            ;;
        -fc)
            FILTER_CODE=$2
            shift
            ;;
        -fw)
            FILTER_WORD=$2
            shift
            ;;
        -o)
            OUTPUT_FILE=$2
            shift
            ;;
        *)
            echo "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
    shift
done

# Determine the base URL
if [ -n "$TARGET_IP" ]; then
    BASE_URL="http://$TARGET_IP"
else
    BASE_URL="http://FUZZ.$TARGET_DOMAIN"
fi

# Construct the ffuf command
FFUF_CMD="ffuf -w $WORDLIST -u $BASE_URL -H Host:FUZZ.$TARGET_DOMAIN"
if [ -n "$FILTER_SIZE" ]; then
    FFUF_CMD+=" -fs $FILTER_SIZE"
fi
if [ -n "$FILTER_CODE" ]; then
    FFUF_CMD+=" -fc $FILTER_CODE"
fi
if [ -n "$FILTER_WORD" ]; then
    FFUF_CMD+=" -fw $FILTER_WORD"
fi
if [ -n "$OUTPUT_FILE" ]; then
    FFUF_CMD+=" -o $OUTPUT_FILE"
fi

# Run the ffuf command for HTTP
echo "Running ffuf for HTTP..."
eval $FFUF_CMD

# Optionally, handle HTTPS as well
echo "Do you want to scan using HTTPS as well? (y/n)"
read -r SCAN_HTTPS

if [ "$SCAN_HTTPS" = "y" ]; then
    if [ -n "$TARGET_IP" ]; then
        BASE_URL="https://$TARGET_IP"
    else
        BASE_URL="https://FUZZ.$TARGET_DOMAIN"
    fi

    FFUF_CMD="ffuf -w $WORDLIST -u $BASE_URL -H Host:FUZZ.$TARGET_DOMAIN"
    if [ -n "$FILTER_SIZE" ]; then
        FFUF_CMD+=" -fs $FILTER_SIZE"
    fi
    if [ -n "$FILTER_CODE" ]; then
        FFUF_CMD+=" -fc $FILTER_CODE"
    fi
    if [ -n "$FILTER_WORD" ]; then
        FFUF_CMD+=" -fw $FILTER_WORD"
    fi
    if [ -n "$OUTPUT_FILE" ]; then
        FFUF_CMD+=" -o $OUTPUT_FILE"
    fi
    echo "Running ffuf for HTTPS..."
    eval $FFUF_CMD
fi
