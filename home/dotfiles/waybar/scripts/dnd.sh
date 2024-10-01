#!/usr/bin/env bash

DND_MODE=$(makoctl mode)

# Check if it's in do-not-disturb mode
if [ "$DND_MODE" == "do-not-disturb" ]; then
    # If it is, switch to default
    makoctl mode -s default
else
    # If it's not, switch to do-not-disturb
    makoctl mode -s do-not-disturb
fi
