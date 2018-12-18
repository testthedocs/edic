---
title: Install
menu: true
weight: 3
---

You can install the pre-compiled binary or compile from source.

**curl**:

> **Caution**: Do not blindly follow these instructions, review our [install script](https://github.com/testthedocs/ttd-cli/blob/master/install.sh) first.

```sh
curl https://raw.githubusercontent.com/testthedocs/redactor/master/install.sh | sh
```

**go get**:

```sh
go get github.com/testthedocs/edic
```

**manually**:

Download the pre-compiled binaries from the [releases page][releases] and
copy to the desired location.

## Compiling From Source

> **Note**: this method requires Go 1.11+.

```sh
git clone git@github.com:testthedocs/edic.git
$ cd edic
$ make setup build install
```

After that, the `edic` binary will be in the root folder:

```sh
./edic --help
```
