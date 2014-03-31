require 'spec_helper'

describe 'repo_centos::contrib' do
  let :facts do
    {
      :operatingsystem        => 'CentOS',
      :os_maj_version         => '6',
      :architecture           => 'x86_64',
    }
  end

  it { should create_class('repo_centos::contrib') }
  it { should contain_class('repo_centos') }

  it do
    should contain_yumrepo('centos-contrib').with({
      :baseurl  => 'http://mirror.centos.org/centos/6/contrib/x86_64',
      :descr    => "CentOS 6 contrib - x86_64",
      :enabled  => '0',
      :gpgcheck => '1',
      :gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
    })
  end

  context 'when repourl => "http://foo.example.com/centos"' do
    let(:pre_condition) { "class { 'repo_centos': repourl => 'http://foo.example.com/centos' }"}

    it { should contain_yumrepo('centos-contrib').with_baseurl('http://foo.example.com/centos/6/contrib/x86_64') }
  end

  context 'when enable_contrib => true' do
    let(:pre_condition) { "class { 'repo_centos': enable_contrib => true }"}

    it { should contain_yumrepo('centos-contrib').with_enabled('1') }
  end
end
