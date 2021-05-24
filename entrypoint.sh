#!/bin/bash

set -e

if [ -z "$ARCHIVE_URL" ]; then
    echo "No archive download url specified, exiting"
    exit 0
fi

if [ -z "$CHAIN_DIR" ]; then
    echo 'Environment variable $CHAIN_DIR should not be empty'
    exit 1
    #
    # With the chain node CLI option --base=/data, $CHAIN_DIR examples:
    #
    ## Kusama:   /data/chains/ksmcc3
    ## Polkadot: /data/chains/polkadot
    ## Darwinia: /data/chains/darwinia
    ## Crab:     /data/chains/crab
fi

CHAIN_DB_PATH=$CHAIN_DIR/db

if [ "$(ls -A \"$CHAIN_DB_PATH\" 2>/dev/null)" ]; then
    echo "Blockchain database already exists, no need to import, exiting"
    exit 0
else
    echo "Did not find pre-existing data, importing blockchain"
    mkdir -p "$CHAIN_DB_PATH"

    echo "Downloading $ARCHIVE_URL..."
    mkdir -p /snapshot
    wget -c -O /snapshot/archive.7z "$ARCHIVE_URL"

    echo "Unarchiving..."
    7z x /snapshot/archive.7z -o$CHAIN_DIR

    echo "Cleaning up..."
    rm -v /snapshot/archive.7z

    echo
    find /polkadot/.local/share/
fi
