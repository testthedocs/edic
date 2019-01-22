---
title: Checks
menu: true
weight: 4
---

*Edic* uses [Rakpart](https://rakpart.testthedocs.org) checks.

# Markdown

Markdown code style linter for [CommonMark](https://commonmark.org/).

From in your docs directory:

```shell
edic md
```

![edic md](/edic-remark-lint.png "edic md")

[Watch on asciinema](https://asciinema.org/a/221968).

- [remark-lint documentation](https://rakpart.testthedocs.org/ttd-remark.html) on Rakpart.

# Linkcheck

Link validation for ``.md`` and ``.rst`` files.

Per default links to `127.0.0.1` and `localhost` are ignored.

From in your docs directory:

```shell
edic linkcheck
```

![edic linkcheck](/edic-linkcheck.png "edic linkcheck")

[Watch on asciinema](https://asciinema.org/a/221970).

- [Linkcheck docs](https://rakpart.testthedocs.org/ttd-linkcheck.html) on Rakpart.

# reStructuredText

A opinionated style checker for rst based documentation.

From in your docs directory:

```shell
edic rst
```

## Default Settings

- Invalid rst format - ``D000``
- Lines should not be longer than 180 characters - ``D001``
  - RST exception: line with no whitespace except in the beginning
  - RST exception: lines with http or https urls
  - RST exception: literal blocks
  - RST exception: rst target directives
- No trailing whitespace - ``D002``
- No tabulation for indentation - ``D003``
- No carriage returns (use unix newlines) - ``D004``
- No newline at end of file - ``D005``

![edic rst](/edic-rst.png "edic rst")

[Watch on asciinema](https://asciinema.org/a/221969).

- [reST docs](https://rakpart.testthedocs.org/ttd-doc8.html) on Rakpart.
