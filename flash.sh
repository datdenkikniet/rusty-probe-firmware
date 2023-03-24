#!/bin/bash

wait_for_mount=5

serial_port=/dev/ttyACM0
if [ -e "$serial_port" ]; then
    echo -ne "\xde\xad\xbe\xef" | tee "$serial_port" > /dev/null
fi

sleep $wait_for_mount

cargo build --release --bin app --no-default-features --features defmt-bbq &&   \
    elf2uf2-rs -s -d target/thumbv6m-none-eabi/release/app |                    \
    defmt-print -e ./target/thumbv6m-none-eabi/release/app --show-skipped-frames