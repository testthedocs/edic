// Copyright © 2019 TestTheDocs
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

package cmd

import (
	"os"
	"os/exec"

	"github.com/spf13/cobra"
)

// linkcheckCmd represents the linkcheck command
var linkcheckCmd = &cobra.Command{
	Use:   "linkcheck",
	Short: "Linkchecker for rst and md files",
	Long: `A Linkchecker for rst and md source files

Links to "localhost" and "0.0.0.0" are ignored.

Based on ttd-linkcheck: https://rakpart.testthedocs.org/ttd-linkcheck.html `,
	Run: func(cmd *cobra.Command, args []string) {
		linkCheck()
	},
}

func linkCheck() {
	// Runs ttd-linkcheck
	cmdStr := "docker run --rm -i -v $PWD:/srv/test testthedocs/ttd-linkcheck"
	cmd := exec.Command("bash", "-c", cmdStr)
	cmd.Stdout = os.Stdout
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
	cmd.Run()
}

func init() {
	rootCmd.AddCommand(linkcheckCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// linkcheckCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// linkcheckCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
