cargo clean
# 1️⃣ Build the kernel 
cargo build -Z build-std=core,alloc,compiler_builtins --target x86_64-duxa_os.json -p kernel

# 2️⃣ Build disk-builder (host target, std)
cargo run -p disk-builder

qemu-system-x86_64 \
  -drive format=raw,file=bios_disk.img \
  -serial stdio \
  -m 512M \
  -boot c \
  -no-reboot \
  -d int \
  -no-shutdown
