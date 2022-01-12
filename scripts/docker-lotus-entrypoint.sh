#!/usr/bin/env bash
  
if [ ! -z $DOCKER_LOTUS_IMPORT_SNAPSHOT ]; then
    GATE="$LOTUS_PATH"/date_initialized
    # Don't init if already initialized.
    if [ ! -f "$GATE" ]; then
        echo importing minimal snapshot
        /usr/local/bin/lotus daemon --import-snapshot "$DOCKER_LOTUS_IMPORT_SNAPSHOT" --halt-after-import
        # Block future inits
        date > "$GATE"
    fi
fi

# import wallet, if provided
if [ ! -z $DOCKER_LOTUS_IMPORT_WALLET ]; then
    mkdir -p $LOTUS_PATH/keystore && /usr/local/bin/lotus-shed keyinfo import "$DOCKER_LOTUS_IMPORT_WALLET"
fi