# SRPM repos for CentOS
class repo_centos::source {

  include repo_centos

  if $repo_centos::enable_source {
    $enabled = '1'
  } else {
    $enabled = '0'
  }

  # Yumrepo ensure only in Puppet >= 3.5.0
  if versioncmp($::puppetversion, '3.5.0') >= 0 {
    Yumrepo <| title == 'centos-base-source' |> { ensure => $repo_centos::ensure_source }
    Yumrepo <| title == 'centos-updates-source' |> { ensure => $repo_centos::ensure_source }
  }

  yumrepo { 'centos-base-source':
    baseurl  => "${repo_centos::source_repourl}/\$releasever/os/Source/",
    descr    => 'CentOS-$releasever - Base Sources',
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::repo_centos::releasever}",
  }

  yumrepo { 'centos-updates-source':
    baseurl  => "${repo_centos::source_repourl}/\$releasever/updates/Source/",
    descr    => 'CentOS-$releasever - Updates Sources',
    enabled  => $enabled,
    gpgcheck => '1',
    gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-${::repo_centos::releasever}",
  }

}
