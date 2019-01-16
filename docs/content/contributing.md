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
- [cobra](https://github.com/spf13/cobra)
- [goreleaser](https://github.com/goreleaser/goreleaser)
- [godownloader](https://github.com/goreleaser/godownloader)
- [Hugo](https://gohugo.io/)

# Release Process

We use [goreleaser](https://github.com/goreleaser/goreleaser) in combination with [godownloader](https://github.com/goreleaser/godownloader).

Follow the steps below to make a new release !

## Release Notes

Write release notes and save them in the directory *release-notes*.

We use as naming scheme the version number, that means the release notes for version 0.0.2 are under
*/release-notes/0.0.2.md*.

## Version

Update the *VERSION* file with the version number you want to release.

Now make sure your branch is clean and you have no uncommitted files or changes.

## Release

Run ``make release`` to create and upload the binaries to GitHub.

## Commit Changes

Commit and push the new created *install.sh* to GitHub.
