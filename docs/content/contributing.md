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
- [gox](https://github.com/mitchellh/gox)
- [ghr](https://github.com/tcnksm/ghr/)
- [Hugo](https://gohugo.io/)

# Release Process

We use [gox](https://github.com/mitchellh/gox)  in combination with [ghr](https://github.com/tcnksm/ghr/).

Follow the steps below to make a new release !

## Release Notes

Write release notes and save them in the directory *release-notes*.

We use as naming scheme the version number, that means the release notes for version 0.0.2 are under
*/release-notes/0.0.2.md*.

### GitHub API Token

To use ``ghr``, you need to get a GitHub token with an account which has enough permissions to to create releases.
To get token, first, visit GitHub account settings page, then go to Applications for the user.

Here you can create a token in the Personal access tokens section.
For a private repository you need *repo* scope and for a public repository you need *public_repo* scope.

When using ``ghr``, you can set it via GITHUB_TOKEN env var, -token command line option or github.token property in .gitconfig file.

We use a ``.env`` file which is **ignored** by git, check the ``Makefile`` for more information.

## Version

Update the *VERSION* file with the version number you want to release.

Now make sure your branch is clean and you have no uncommitted files or changes.

## Release

Run ``make release`` to create and upload the binaries to GitHub.

## Commit Changes

Commit and push the new created *install.sh* to GitHub.
