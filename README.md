# Edic

Editor In Chief

## Description

*[Edic (Editor In Chief)](https://github.com/testthedocs/edic)* is QA
tool for documentation, written in [reStructuredText](https://en.wikipedia.org/wiki/ReStructuredText) and [CommonMark Markdown](https://commonmark.org/).

*Edic* is a wrapper around [Docker](https://www.docker.com/); build for **local** usage.

All checks are based on [Rakpart](https://rakpart.testthedocs.org)

## Prerequisites

- [Docker](https://docker.com)

## Documentation

Read the documentation on the [website](https://edic.testthhedocs.org).

## Usage

```shell
edic help
QA checks for documentation, written in reStructuredText and CommonMark Markdown.

Edic is a wrapper around Docker; build for local usage.
All tests are based on Rakpart (https://rakpart.testthedocs.org).

Usage:
  edic [command]

Available Commands:
  help        Help about any command
  linkcheck   Linkchecker for rst and md files
  md          Checks Markdown Syntax (CommonMark Style)
  rst         Checks reStructuredText Syntax
  version     Show the version information

Flags:
      --config string   config file (default is $HOME/.edic.yaml)
  -h, --help            help for edic
  -t, --toggle          Help message for toggle

Use "edic [command] --help" for more information about a command.

```

## Install

Browse o the [release page](https://github.com/testthedocs/edic/releases) and download the binary according to your OS.


To install, use `go get`:

```shell
go get -d github.com/testthedocs/edic
```

## Versioning

We use [SemVer](https://semver.org/) for versioning.
For the versions available, see the [tags on this repository](https://github.com/testthedocs/edic/tags).

## Contributing

Please read [CONTRIBUTING.md](https://edic.testthedocs/contributing) for details on our code of conduct, and the process for submitting pull requests to us.

## License

[MIT](https://choosealicense.com/licenses/mit/)

## Acknowledgments

- This is work in progress, the code and features are still early alpha
- Functionality will change
