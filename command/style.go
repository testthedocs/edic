package command

import "github.com/codegangsta/cli"

func CmdStyle(c *cli.Context) {
	// Write your code here
        cmdStr := "docker run -it -v $PWD:/srv/tests testthedocs/ttd-vale"
        cmd := exec.Command("bash", "-c", cmdStr)
	cmd.Stdout = os.Stdout
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
        cmd.Run()

}
