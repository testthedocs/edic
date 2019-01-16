---
title: Install
menu: true
weight: 3
---

You can install the pre-compiled binary or compile from source.

**go get**:

```sh
go get github.com/testthedocs/edic
```

**manually**:

Download the pre-compiled binaries from the [releases page](https://github.com/testthedocs/edic/releases) and
copy to the desired location.

# Compiling From Source

> **Note**: this method requires Go 1.11+.

```sh
git clone git@github.com:testthedocs/edic.git
cd edic
make setup
make install
```

After that, the `edic` binary will be in your `$GOBIN` folder.

![edic help](/edic-help.png "edic help")
