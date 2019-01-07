package main

import (
	"fmt"
	"os"

	"github.com/codegangsta/cli"
	"github.com/testthedocs/edic/command"
)

// GlobalFlags : Settings for global CLI
var GlobalFlags = []cli.Flag{}

// Commands : List of all commands
var Commands = []cli.Command{
	{
		Name:   "md",
		Usage:  "Checks Markdown Syntax (CommonMark Style)",
		Action: command.CmdMd,
		Flags:  []cli.Flag{},
	},
	{
		Name:   "linkcheck",
		Usage:  "Checks Links",
		Action: command.CmdLinkcheck,
		Flags:  []cli.Flag{},
	},
	{
		Name:   "style",
		Usage:  "Checks Style (based on Vale)",
		Action: command.CmdStyle,
		Flags:  []cli.Flag{},
	},
	{
		Name:   "rst",
		Usage:  "Checks reStructuredText",
		Action: command.CmdRst,
		Flags:  []cli.Flag{},
	},
}

// CommandNotFound : If command is not found return the help
func CommandNotFound(c *cli.Context, command string) {
	fmt.Fprintf(os.Stderr, "%s: '%s' is not a %s command. See '%s --help'.", c.App.Name, command, c.App.Name, c.App.Name)
	os.Exit(2)
}
