cargo clean
cargo build -Z build-std=core,alloc,compiler_builtins --target x86_64-duxa_os.json -p kernel

cargo run -p disk-builder

qemu-system-x86_64 \
  -drive format=raw,file=./disk-builder/bios_disk.img \
  -serial stdio \
  -m 2048M \
  -boot c \
  -no-reboot \
  -no-shutdown
