# @summary This profile installs unzip and git as part of the Windows baseline
class profile::windows_baseline {

exec { 'winrm-enable':
  provider => powershell,
  command => 'winrm quickconfig -quiet',
  unless => 'if(!(test-wsman -erroraction silentlycontinue)) { exit 1 }',
}

}

