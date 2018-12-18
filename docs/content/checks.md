---
title: Checks
menu: true
weight: 4
---

*Edic* uses [Rakpart](https://rakpart.testhedocs.org) checks.

# Markdown

Markdown code style linter for [CommonMark](https://commonmark.org/).

From in your docs directory:

```shell
edic md
```

![edic md](/edic-remark-lint.png "edic md")

- [Rackpart documentation](https://rakpart.testthedocs.org/ttd-remark.html)

# Linkcheck

Link validation for ``.md`` and ``.rst`` files.

Per default links to `127.0.0.1` and `localhost` are ignored.

From in your docs directory:

```shell
edic linkcheck
```

![edic linkcheck](/edic-linkcheck.png "edic linkcheck")

- [Linkcheck docs](https://rakpart.testthedocs.org/ttd-linkcheck.html) on Rakpart.

# reStructuredText

A opinionated style checker for rst based documentation.

From in your docs directory:

```shell
edic rst
```

![edic rst](/edic-rst.png "edic rst")

- [reST docs](https://rakpart.testthedocs.org/ttd-doc8.html) on Rakpart.
