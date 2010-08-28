directory node[:homebrew][:prefix] do
  action :create
end

homebrew_tar = "#{Chef::Config[:file_cache_path]}/mxcl-homebrew.tar.gz"

remote_file homebrew_tar do
  source "http://github.com/mxcl/homebrew/tarball/master"
  action :create_if_missing
end

execute "tar -xzf #{homebrew_tar} -C #{node[:homebrew][:prefix]} --strip 1" do
  creates "#{node[:homebrew][:prefix]}/bin/brew"
end

execute "#{node[:homebrew][:prefix]}/bin/brew --version"

package "git"

execute "#{node[:homebrew][:prefix]}/bin/brew update"
