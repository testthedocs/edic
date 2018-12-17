package command

import "github.com/codegangsta/cli"

func CmdRst(c *cli.Context) {
	// Write your code here
        cmdStr := "docker run --rm -i -v $PWD:/srv/data:ro testthedocs/ttd-doc8"
        cmd := exec.Command("bash", "-c", cmdStr)
	cmd.Stdout = os.Stdout
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
        cmd.Run()
}

}
