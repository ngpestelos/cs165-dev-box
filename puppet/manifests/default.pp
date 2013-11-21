$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}
class { 'apt_get_update':
  stage => preinstall
}

# --- PostgreSQL ---------------------------------------------------------------

class install_postgres {
  class { 'postgresql': }

  class { 'postgresql::server':
    listen => ['192.168.33.10', ],
    port => 5432,
    acl => ['host all all 192.168.33.1/0 md5', ''],
  }

  pg_database { 'test_database':
    ensure   => present,
    encoding => 'UTF8',
    require  => Class['postgresql::server']
  }

  pg_user { 'vagrant':
    ensure    => present,
    superuser => true,
    password => 'password',
    require   => Class['postgresql::server']
  }

  package { 'libpq-dev':
    ensure => installed
  }

  package { 'postgresql-contrib':
    ensure  => installed,
    require => Class['postgresql::server'],
  }
}
class { 'install_postgres': }

# --- Packages -----------------------------------------------------------------

package { 'vim':
  ensure => installed
}

package { 'curl':
  ensure => installed
}

package { 'wget':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}

package { 'libcurl4-openssl-dev':
  ensure => installed
}
