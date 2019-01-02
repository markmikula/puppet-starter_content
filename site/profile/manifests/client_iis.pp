# @summary This profile installs IIS and turns off the default website
<<<<<<< HEAD:site/profile/manifests/client_iis.pp
class profile::clientiis {
=======
class profile::client_iis {
>>>>>>> 2d5f72ac77b40e15a6fac8e254ae9adca92989d3:site/profile/manifests/client_iis.pp

  include profile::windows_baseline

  $iis_features = [
    'web-server',
    'net-framework-45-aspnet',
    'net-framework-45-core',
    'net-framework-45-features',
    'net-wcf-services45',
    'net-wcf-tcp-portsharing45',
    'telnet-client',
    'web-app-dev',
    'web-asp-net45',
    'web-basic-auth',
    'web-cert-auth',
    'web-certprovider',
    'web-client-auth',
    'web-common-http',
    'web-default-doc',
    'web-digest-auth',
    'web-dir-browsing',
    'web-dyn-compression',
    'web-filtering',
    'web-health',
    'web-http-errors',
    'web-http-logging',
    'web-http-redirect',
    'web-http-tracing',
    'web-ip-security',
    'web-isapi-ext',
    'web-isapi-filter',
    'web-log-libraries',
    'web-mgmt-console',
    'web-mgmt-service',
    'web-mgmt-tools',
    'web-net-ext45',
    'web-performance',
    'web-request-monitor',
    'web-scripting-tools',
    'web-security',
    'web-stat-compression',
    'web-static-content',
    'web-url-auth',
    'web-webserver',
    'web-windows-auth'  

  ]

  windowsfeature { $iis_features:
    ensure => present,
  }

  iis::manage_site { 'Default Web Site':
    ensure => absent,
  }


  #Web Platform Installer
  $file = 'WebPlatformInstaller_amd64_en-US.msi'
  $url  = "http://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/${file}"
  $temp = "C:\\Windows\\Temp\\${file}"

exec { 'download_webplatforminstaller':
  provider  => powershell,
  # note that Start-BitsTransfer can't handle redirected URLs
  command   => "(New-Object Net.WebClient).DownloadFile(\"${url}\", \"${temp}\")",
  creates   => $temp
}

package { 'Microsoft Web Platform Installer 5.0':
  ensure  => '5.0.50430.0',
  source  => $temp,
}

}

