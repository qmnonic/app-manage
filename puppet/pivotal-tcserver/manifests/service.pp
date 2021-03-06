## Web Server Puppet Module
##
## Copyright 2013 GoPivotal, Inc
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
## Configuration Information
##

define tcserver::service (
  $ensure = running,
  $name = undef,
  $cwd = undef,
) {
  if $ensure == absent {
    service { "tcserver-instance-${name}":
      ensure    => stopped,
      status    => "ps -p `cat ${cwd}/${name}/logs/tcserver.pid` > /dev/null 2>&1",
    }
    service { "${name}":
      ensure    => stopped,
      status    => "ps -p `cat ${cwd}/${name}/logs/tcserver.pid` > /dev/null 2>&1",
    }
  } else {
    service { "${name}":
      ensure    => $ensure,
      status    => "ps -p `cat ${cwd}/${name}/logs/tcserver.pid` > /dev/null 2>&1",
      require   => File["${cwd}/${name}"]
    }
  }
}
