#!/bin/bash
# Copyright 2014 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

echo "---> Installing EPEL"
#su -c 'rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm'

echo "---> Installing Docker"
su -c 'yum -q -y install docker-io unzip'

echo "---> Installing Packer"
cd /tmp
wget https://dl.bintray.com/mitchellh/packer/0.5.2_linux_amd64.zip -O packer.zip | /dev/null vagrant
unzip -d packer packer.zip
su -c "mv packer /usr/local/packer"
su -c "ln -s /usr/local/packer/* /usr/bin/"

echo "---> Starting Docker"
su -c 'service docker start > /dev/null'
echo "---> Enabling TUN/TAP interfaces"
su -c "modprobe tun"