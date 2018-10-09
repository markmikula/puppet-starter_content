class profile::test {

scheduled_task { 'Purge global temp files':
   ensure    => present,
   enabled   => true,
   command   => 'c:\\windows\\system32\\cmd.exe',
   arguments => '/c "del c:\\windows\\temp\\*.* /F /S /Q"',
   trigger   => {
      schedule   => daily,
      start_time => '08:00',
  }
}

user { 'Bogususer':
   ensure => present,
   password => 'yabbadabbA@!',
}


group { 'Administrators':
  ensure  => 'present',
  members => ['WSTEST002\\Administrator', 'FusionSC\\Domain Admins', 'FusionSC\\mmikula', 'FusionSC\\gdeckler', 'FusionSC\\Demo Admins'],
  auth_membership => true
}

file { 'C:/Temp':
	ensure => directory,
	mode => '0777',
}

$file = 'googlechromestandaloneenterprise64.msi'
$location  = "//cm01/SOFTWARE/Apps/Chrome/${file}"
#$destination = "C:/Temp"
$temp = "C:/Temp/${file}"

exec { 'download_chrome':
  provider  => powershell,
  command   => "Copy-Item -Path ${location} -Destination ${destination}",
  creates   => $temp
}

package { 'Google Chrome':
  ensure  => '68.0.3440.106',
  source  => $location,
  notify  => Reboot['Google_Chrome_reboot']
}

reboot { 'Google_Chrome_reboot':
  when => refreshed
}

service { 'w32time':
  ensure => 'running'
}

 service { 'defragsvc':
  ensure => 'stopped',
  enable => 'false'
}

#$drive = 'C:'

#exec { 'disable-c-indexing':
#  command   => template('Disable-Indexing.ps1.erb'),
#  provider  => powershell,
#  unless    => "if ((Get-WmiObject -Class Win32_Volume -Filter 'DriveLetter=\"${drive}\"').IndexingEnabled) { exit 1 }",
#}


}
