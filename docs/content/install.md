---
title: Install
menu: true
weight: 3
---

You do not need to install Go to enjoy Edic. Grab a precompiled binary!

Edic is written in [Go](http://git-scm.com/) with support for multiple platforms.
The latest release can be found at [Edic Releases](https://github.com/testthedocs/edic/releases).

## Binary (Cross-platform)

### Step 1: Decide On The Location

When installing the binary, you have to decide if you’re going to install the binary in `/usr/local/bin` or in your home directory.

1. Install it in `/usr/local/bin` so that all the users on your system have access to it.
This is a good idea because it’s a fairly standard place for runnable applications.
The downside is that you may need elevated privileges to put software into that location.
Also, if there are multiple users on your system, they will all run the same version.
Sometimes this can be an issue if you want to try out a new release

2. Install it in `~/bin` so that only you can run it.
This is a good idea because it’s easy to do, easy to maintain, and doesn’t require elevated privileges.
The downside is that only you can run Edic.
If there are other users on your site, they have to maintain their own copies.
That can lead to people running different versions.
Of course, this does make it easier for you to experiment with different releases.

### Step 2: Download the Binary

Download the appropriate version for your platform from the [releases page](https://github.com/testthedocs/edic/releases).

By default, the binary will be saved to your `~/Downloads` directory.
If you choose to use a different location, you will need to change that in the following steps.

The name will be something like edic_darwin_amd64 (macOS).

### Step 3: Install It.

For this example we will install the binary into `~/bin` so that only you can run it.

```shell
# create the directory if needed
mkdir -p ~/bin

# make it the working directory
cd ~/bin

# copy the binary into place
cp ~/Downloads/edic_darwin_amd64 .

# rename the binary to edic
mv edic_darwin_amd64 edic

# make it 'runnable'
chmod +x edic

# verify that it runs
./edic version
Version: v0.0.2
Build Date: 2019-01-18
Git Commit: 1d81e6e
OS: darwin
Arch: amd64
```

You may need to add your bin directory to your `PATH` variable.
The `which` command will check for us.
If it can find Edic, it will print the full path to it.

Otherwise, it will not print anything.

```shell
# check if edic is in the path
which edic
/Users/USERNAME/bin/edic
```

If `edic` is not in your `PATH`, add it by updating your ~/.bash_profile file.
First, start up an editor:

```shell
nano ~/.bash_profile
```

Add a line to update your `PATH` variable:

```shell
export PATH=$PATH:$HOME/bin
```

Then save the file by pressing Control-X, then Y to save the file and return to the prompt.

Close the terminal and open a new terminal to pick up the changes to your profile.
Verify your success by running the `which edic` command again.

You’ve successfully installed Edic.

## Fetch from GitHub

> Note this method is **only** suited for more seasoned user and/or people who work with Go on a daily basis.
> The binary install should be enough for most people !

### Prerequisite Tools

- [Go (at least Go 1.11)](https://golang.org/dl/)

```sh
go get github.com/testthedocs/edic
```

## Compiling From Source

> Note this method is **only** suited for more seasoned user and/or people who work with Go on a daily basis.
> The binary install should be enough for most people !

### Prerequisite Tools

- [Git](http://git-scm.com/)
- [Go (at least Go 1.11)](https://golang.org/dl/)
- [dep](https://github.com/golang/dep/)

```sh
git clone git@github.com:testthedocs/edic.git
cd edic
dep ensure -u
```

After that, the `edic` binary will be in your `$GOBIN` folder.

![edic help](/edic-help.png "edic help")
