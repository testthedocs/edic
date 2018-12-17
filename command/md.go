package command

import "github.com/codegangsta/cli"

func CmdMd(c *cli.Context) {
	// Write your code here
        cmdStr := "docker run --rm -i -v $PWD:/lint/input:ro zemanlx/remark-lint ."
        cmd := exec.Command("bash", "-c", cmdStr)
	cmd.Stdout = os.Stdout
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
        cmd.Run()

}
