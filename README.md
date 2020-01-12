# PerfectPitch
Ear training app for Elementary OS

## Installation

### Dependencies

You'll need the following dependencies to build:

* libgranite-dev
* libgtk-3-dev
* libgstreamer1.0-dev
* meson
* valac

### Building

```bash
meson build --prefix=/usr
cd build
ninja
```

### Installing & executing

To install, use `ninja install`, then execute with `com.github.artempopof.perfectpitch`.

```bash
sudo ninja install
com.github.artempopof.perfectpitch
```
