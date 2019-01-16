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

// rstCmd represents the rst command
var rstCmd = &cobra.Command{
	Use:   "rst",
	Short: "Checks reStructuredText Syntax",
	Long: `reStructuredText code style linter

Default Settings:
Invalid rst format - D000
Lines should not be longer than 180 characters - D001
RST exception: line with no whitespace except in the beginning
RST exception: lines with http or https urls
RST exception: literal blocks
RST exception: rst target directives
No trailing whitespace - D002
No tabulation for indentation - D003
No carriage returns (use unix newlines) - D004
No newline at end of file - D005

Based on https://rakpart.testthedocs.org/ttd-doc8.html`,
	Run: func(cmd *cobra.Command, args []string) {
		rstCheck()
	},
}

func rstCheck() {
	// Runs ttd-linkcheck
	cmdStr := "docker run -it -v `pwd`:/srv/data testthedocs/ttd-doc8"
	cmd := exec.Command("bash", "-c", cmdStr)
	cmd.Stdout = os.Stdout
	cmd.Stdin = os.Stdin
	cmd.Stderr = os.Stderr
	cmd.Run()
}

func init() {
	rootCmd.AddCommand(rstCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// rstCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// rstCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
