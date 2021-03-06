require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package("openjdk-8-jre-headless") do
  it { should be_installed }
end

describe file("/opt/atlassian-crowd") do
  it { should be_symlink }
  it { should exist }
end

describe file("/opt/atlassian-crowd-2.12.0") do
  it { should be_directory }
  it { should exist }
  it { should be_owned_by 'crowd' }
  it { should be_grouped_into 'crowd' }
  it { should be_mode 755 }
end

if `salt-call --local grains.get init`.include? "systemd"
  describe file("/lib/systemd/system/crowd.service") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
else
  describe file("/etc/init.d/crowd") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end
end

describe service("crowd") do
  it { should be_running }
end

describe port(8095) do
  it { should be_listening }
end
