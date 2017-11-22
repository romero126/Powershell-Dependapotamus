


#$DEBUG = @{}
#$DEBUG.ENABLED = $true
#$DEBUG.NOTIFICATIONS = $true
#$DEBUG.UI_COLLIDER = @{}
#$DEBUG.UI_COLLIDER.DISPATCHER = $true

#Send-MailMessage -To "Juan Romero v-jurom@microsoft.com" -From "Notifications <v-jurom@microsoft.com>" -Subject "Test mail" -SmtpServer smtphost.redmond.corp.microsoft.com

#$DEBUG.WORKFLOW = $true
#$DEBUG = $null

$File = $SCRIPT:MyInvocation.MyCommand.Path
$FilePath = split-path $SCRIPT:MyInvocation.MyCommand.Path -parent
[xml]$Settings = get-content "$(split-path $SCRIPT:MyInvocation.MyCommand.Path -parent)\Settings.xml"
. ([ScriptBlock]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($Settings.MAIN.BIN.START))))
