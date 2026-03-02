# cargo clean
echo "Running kernel compilation"
cargo build -p kernel -Z build-std=core,alloc,compiler_builtins

echo "Running disk-builder"
cargo run -p disk-builder --target x86_64-unknown-linux-gnu
echo "Running QEMU"
qemu-system-x86_64 \
    -drive format=raw,file=./disk-builder/bios_disk.img \
    -serial stdio \
    -m 4096M \
    -boot c \
    -no-reboot \
    -no-shutdown \
    -machine pc \
    -device isa-debug-exit,iobase=0xf4,iosize=0x04
