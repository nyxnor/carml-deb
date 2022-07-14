# carml-deb

Unofficial debian packaging for [meejah/carml](https://github.com/meejah/carml).

##  Build

### Build the package

Install developer scripts:
```sh
sudo apt install -y devscripts
```

Install build dependencies.
```sh
sudo mk-build-deps --remove --install
```

If that did not work, have a look in debian/control file and manually install all packages listed under Build-Depends and Depends.

Build the package without signing it (not required for personal use) and install it.
```sh
sudo dpkg-buildpackage -b --no-sign
```

### Install the package

The package can be found in the parent folder. Install the package:
```sh
sudo dpkg -i ../carml_*.deb
```
