# Examples For PowerShell

This is personal folder for me to work on scripting. It is not used in project but includes examples to work on scripting.

Script structure to follow: [https://github.com/MSAdministrator/TemplatePowerShellModule]

## Windows PowerShell Cheat Sheet

For a quick [PowerShell scripting tutorial]

### [ExecutionPolicy]

- `Get-ExecutionPolicy`. Some possible policy levels:
  - `Restricted`: you can't run scripts. You can run only commands.
  - `RemoteSigned`: scripts written on the local computer can run. Scripts downloaded from the internet need to be signed by a digital signature from a trusted publisher.
  - `Unrestricted`: default execution policy for non-Windows computers and cannot be changed. Unsigned scripts can run.
  - `Bypass`: Nothing is blocked and there are no warnings or prompts.
- `Set-ExecutionPolicy`
  - Example: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`
  - `-ExecutionPolicy` parameter specifies policy. It's a good idea to use `Default` as the value. It sets the policy to Restricted on Windows clients and RemoteSigned on Windows Server.
  - `-Scope` parameter specifies scope of command. Some possible ones:
    - `Process`: Only affects the current PowerShell session
    - `LocalMachine`: This is default one. Execution policy affects all users on the current computer. It's stored in the HKEY_LOCAL_MACHINE registry.

### Profile

- `$Profile | Select-Object *`: To see the profile types and the paths.
- `New-Item -Path $Profile.CurrentUserCurrentHost`: This will create profile script in the location.

### Simple Commands For Scripting

- Creates a profile for current user

      New-Item `
      -ItemType "file" `
      -Value 'Write-Host "Hello <replace with your name>, welcome back" -foregroundcolor Green ' `
      -Path $Profile.CurrentUserCurrentHost -
- Create a script file `New-Item -Path . -Name "PI.ps1" -ItemType "file"`
- Open file in VS Code `code PI.ps1`
- Run script `./PI.ps1`
- `mv app webapp`: rename app directory to webapp
- `rm backup.zip`: remove backup.zip

[PowerShell scripting tutorial]: https://learn.microsoft.com/en-us/training/modules/script-with-powershell/2-introduction-scripting
[ExecutionPolicy]: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3
