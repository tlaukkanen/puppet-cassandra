require 'spec_helper'

describe 'cassandra::config' do

  let(:params) do
    {
      :max_heap_size              => '',
      :heap_newsize               => '',
      :jmx_port                   => 7199,
      :additional_jvm_opts        => [],
      :cluster_name               => 'Cassandra',
      :listen_address             => '1.2.3.4',
      :rpc_address                => '0.0.0.0',
      :rpc_port                   => 9160,
      :rpc_server_type            => 'hsha',
      :storage_port               => 7000,
      :partitioner                => 'org.apache.cassandra.dht.RandomPartitioner',
      :data_file_directories      => ['/var/lib/cassandra/data'],
      :commitlog_directory        => '/var/lib/cassandra/commitlog',
      :saved_caches_directory     => '/var/lib/cassandra/saved_caches',
      :initial_token              => '',
      :seeds                      => ['1.2.3.4'],
      :concurrent_reads           => 32,
      :concurrent_writes          => 32,
      :incremental_backups        => 'false',
      :snapshot_before_compaction => 'false',
      :auto_snapshot              => 'true',
      :multithreaded_compaction   => 'false',
      :endpoint_snitch            => 'SimpleSnitch',
    }
  end

  it 'does contain group cassandra' do
    should contain_group('cassandra').with({
      :ensure  => 'present',
      :require => 'Class[Cassandra::Install]',
    })
  end

  it 'does contain user cassandra' do
    should contain_user('cassandra').with({
      :ensure  => 'present',
      :require => 'Group[cassandra]',
    })
  end

  it 'does contain file /etc/cassandra/cassandra-env.sh' do
    should contain_file('/etc/cassandra/cassandra-env.sh').with({
      :ensure  => 'file',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0644',
      :content => /MAX_HEAP_SIZE/,
    })
  end

  it 'does contain file /etc/cassandra/cassandra.yaml' do
    should contain_file('/etc/cassandra/cassandra.yaml').with({
      :ensure  => 'file',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0644',
      :content => /cluster_name: 'Cassandra'/,
    })
  end
end
