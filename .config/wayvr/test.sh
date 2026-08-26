#!/usr/bin/env bash

SCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

env TESTBED="$SCRIPTDIR/theme/gui/$1.xml" wayvr-uidev