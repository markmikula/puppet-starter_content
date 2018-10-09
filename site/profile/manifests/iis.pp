# @summary This profile installs IIS and turns off the default website
class profile::iis {

$Variable = 'Web-Server'

  $iis_features = [
    ${Variable},
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
    'web-server',
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

}
