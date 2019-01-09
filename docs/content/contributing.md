---
title: Contributing
menu: true
weight: 6
---

Reference points about contributing and developing.

- [Commit Guidelines](https://rakpart.testthedocs.org/commit-guidelines.html)
- [Code Of Conduct](https://rakpart.testthedocs.org/code-of-conduct.html)

# Dependencies

- [dep](https://github.com/golang/dep/)

We use `dep` for dependency management and pining.

# Getting Started

Clone the repository:

```shell
cd $PATH_TO_YOUR_GOPATH/src/github.com
git clone https://github.com/testthedocs/edic.git
```

Install dependencies with `dep`:

```shell
dep ensure -vendor-only
```

Or run ``make setup`` from the /root of the repository.
