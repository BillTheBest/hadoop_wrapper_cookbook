#
# Cookbook Name:: hadoop_wrapper
# Recipe:: hive_init
#
# Copyright 2013, Continuuity
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'hadoop_wrapper::default'
include_recipe 'hadoop::default'
include_recipe 'hadoop::hive'

dfs = node['hadoop']['core_site']['fs.defaultFS']

execute "initaction-create-hive-hdfs-homedir" do
  not_if  "hdfs dfs -test -d #{dfs}/user/hive", :user => "hive"
  command "hdfs dfs -mkdir -p #{dfs}/user/hive && hdfs dfs -chown hive:hdfs #{dfs}/user/hive"
  timeout 300
  user "hdfs"
  group "hdfs"
end

execute "initaction-create-hive-hdfs-warehouse" do
  not_if  "hdfs dfs -test -d #{dfs}/apps/hive/warehouse", :user => "hive"
  command "hdfs dfs -mkdir -p #{dfs}/apps/hive/warehouse && hdfs fs -chown hive:hdfs #{dfs}/apps/hive && hdfs dfs -chmod 775 #{dfs}/apps/hive"
  timeout 300
  user "hdfs"
  group "hdfs"
end

execute "initaction-create-hive-hdfs-scratch" do
  not_if  "hdfs dfs -test -d #{dfs}/tmp/scratch", :user => "hive"
  command "hdfs dfs -mkdir -p #{dfs}/tmp/scratch && hdfs dfs -chown hive:hdfs #{dfs}/tmp/scratch && hdfs dfs -chmod 777 #{dfs}/tmp/scratch"
  timeout 300
  user "hdfs"
  group "hdfs"
end
