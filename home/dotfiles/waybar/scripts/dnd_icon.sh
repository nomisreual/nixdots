#!/usr/bin/env bash

# Get the current mode
DND_MODE=$(makoctl mode)

# Output icon based on the mode
if [ "$DND_MODE" == "do-not-disturb" ]; then
    echo ""  # Bell icon (for default mode)
else
    echo ""  # Coffee cup icon (or any other DND icon)
fi
