---
title: Introduction
weight: 1
menu: true
---

*[Edic (Editor In Chief)](https://github.com/testthedocs/edic)* is QA
tool for documentation, written in [reStructuredText](https://en.wikipedia.org/wiki/ReStructuredText) and [CommonMark Markdown](https://commonmark.org/).

*Edic* is a wrapper around [Docker](https://www.docker.com/); build for **local** usage.

Besides using a well configured editor, sometimes you want to run QA checks against your (whole) documentation.

Doing so, will provide important insights about the status or your docs.

This should be as effortless as possible.

*Edic* is born out of this need.

Be able to run the same checks locally and on CI, using the same configuration, without having a hard time to remember long command line syntaxes.

![edic help](/edic-help.png "edic help")

All checks are based on [Rakpart](https://rakpart.testthedocs.org), which is also used in CI.

:white_check_mark:
