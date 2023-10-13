# Vicharak u-boot building scripts

U-Boot building scripts for Vicharak's ARM64 devices.

## Installation

1. Using Git submodule

```bash
git submodule add -b master https://github.com/vicharak-in/u-boot-scripts vicharak
```

2. Downloading the scripts

```bash
wget -qO vicharak.tar.gz https://github.com/vicharak-in/u-boot-scripts/archive/refs/heads/master.tar.gz
tar -xf vicharak.tar.gz
mv u-boot-scripts-master vicharak
rm -f vicharak.tar.gz
```

## Usage

```bash
./vicharak/build.sh -h
```

## License

[MIT](./LICENSE.MIT)
