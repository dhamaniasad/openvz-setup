openvz-setup
=========

CentOS 6 and Debian 7 OpenVZ setup script

### Introduction

This is a setup script which automatically installs and configures OpenVZ on a server running either CentOS 6 or Debian 7. No manual intervention is required. If you prefer using a panel, please have a look at [my other project](https://github.com/dhamaniasad/vzvirtpanel). Please note that it is strongly advised that you use a fresh installation of CentOS/Debian while using this script to prevent running into issues.

### Installation

#### CentOS 6

    wget --no-check-certificate https://github.com/dhamaniasad/openvz-setup/raw/master/setup.sh -O - | sh

#### Debian 7

    wget --no-check-certificate https://github.com/dhamaniasad/openvz-setup/raw/master/setup-deb.sh -O - | sh
    
##### Please note that CentOS 6 and Debian 7(i.e., the latest versions) are recommended for a VPS node, and this script isn't backwards compatible with older versions.
