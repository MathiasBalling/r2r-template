# Templates for r2r

All templattes integrate with the ros2 colcon build system.

[See r2r examples](https://github.com/sequenceplanner/r2r/tree/master/r2r/examples)

## Standalone r2r

```bash
cargo run --bin {package_name}
```

Or via colcon build system

```bash
colcon build --symlink-install
ros2 run {package_name} {binary_name}
```

See more in [text](url)

## r2r with opencv

Use provided flake.nix or

```bash
sudo apt install -y libopencv-dev clang libclang-dev # For opencv-rust
```
