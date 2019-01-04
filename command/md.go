package command

import (
    "github.com/codegangsta/cli"
    "os"
    "os/exec"
)

func CmdMd(c *cli.Context) {
	// Write your code here
        cmdStr := "docker run --rm -i -v $PWD:/lint/input:ro testthedocs/ttd-remark ."
        cmd := exec.Command("bash", "-c", cmdStr)
	cmd.Stdout = os.Stdout
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
        cmd.Run()

}
