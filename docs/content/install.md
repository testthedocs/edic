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

```sh
edic -h
NAME:
   edic - Editor In Chief

USAGE:
   edic [global options] command [command options] [arguments...]

VERSION:
   0.0.1

AUTHOR:
   testthedocs

COMMANDS:
     md         Checks Markdown Syntax (CommonMark Style)
     linkcheck  Checks Links
     style      Checks Style (based on Vale)
     rst        Checks reStructuredText
     help, h    Shows a list of commands or help for one command

GLOBAL OPTIONS:
   --help, -h     show help
   --version, -v  print the version
```
