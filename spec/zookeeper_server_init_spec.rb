require 'spec_helper'

describe 'hadoop_wrapper::zookeeper_server_init' do
  context 'on Centos 6.4 x86_64' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'centos', version: 6.4) do |node|
        node.automatic['domain'] = 'example.com'
        node.automatic['memory']['total'] = '4099400kB'
        stub_command('update-alternatives --display hadoop-conf | grep best | awk \'{print $5}\' | grep /etc/hadoop/conf.chef').and_return(false)
        stub_command('update-alternatives --display zookeeper-conf | grep best | awk \'{print $5}\' | grep /etc/zookeeper/conf.chef').and_return(false)
      end.converge(described_recipe)
    end

    it 'runs initaction-zookeeper-init execute block' do
      expect(chef_run).to run_execute('initaction-zookeeper-init')
    end
  end
end
