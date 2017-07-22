# crowd-formula
Install and configure Atlassian Crowd

## Usage
see `defaults.yml` and `pillar-custom.sls` for more information.
```
crowd:
  enabled: true
  mockup: true
  app_name: atlassian-crowd
  version: 2.12.0
  pkg_hash: f53d9d6c1028c6f12ec4292579608fce5f926e40437d7795859e765584d2d6cd
  required_java: openjdk-8-jre-headless
  required_pkgs_repo: jessie-backports
  service:
    name: crowd
    state: running
    enable: true
  mysql_connector:
    hash: bc23a03d813af3f7ac44b8e7a5cb0d54
    version: 5.1.42
```
## Development
Install and setup brew:
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

```
brew install cask
brew cask install vagrant
```

```
cd <formula dir>
bundle install
```
or
```
sudo gem install test-kitchen
sudo gem install kitchen-vagrant
sudo gem install kitchen-salt
```

Run a converge on the default configuration:
```
kitchen converge default
```
