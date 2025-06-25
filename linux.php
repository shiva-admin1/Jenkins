<?php
// Run Linux Commands PHP Script
// Equivalent to GitHub Actions workflow

function runCommand($title, $command) {
    echo "### $title\n";
    echo "Command: $command\n";
    echo "------------------------\n";
    $output = shell_exec($command);
    echo $output . "\n";
    echo "========================\n\n";
}

// Step 1: Print Workspace Info
runCommand("Workspace Directory", "pwd");
runCommand("List Contents", "ls -lah");

// Step 2: Run Basic Linux Commands
runCommand("Current User", "whoami");
runCommand("Disk Usage", "df -h");
runCommand("System Uptime", "uptime");
runCommand("Environment Variables", "printenv");

?>

