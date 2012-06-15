#!/usr/bin/env ruby

# test with 1.9.2

require 'optparse'
require 'pathname'

$verbose = false
$backup_interval = 'daily'

def v(msg)
	puts msg if $verbose
end

def get_projected_backup_dir()
	time = Time.new
	format = case $backup_interval
		when 'daily' then '%Y%m%d'
		when 'weekly'
			time -= time.wday * 24 * 3600
			'%Y%m%d'
		when 'monthly' then '%Y%m01'
		when 'yearly' then '%Y0101'
		else abort "Unsupported backup interval: #{$backup_interval}"
	end
	time.strftime(format)
end

optparse = OptionParser.new do |opts|
	opts.banner = <<EOF
Usage: rsync-backup-helper.rb [options] srcdir backupdir'

Example:
  rsync-backup-helper.rb -p -m daily C:/mywork E:/mywork-backup

EOF
	
	opts.on('-h', '-?', '--help', 'display this screen') do
		puts opts
		exit
	end
	
	opts.on('-v', '--verbose', 'verbose mode on') do
		$verbose = true
	end
	
	opts.on('-o', '--output FILE', 'output script to file') do |v|
		$output_file = v
	end
	
	opts.on('-p', '--pushd', 'generate script that uses windows pushd') do |v|
		$use_pushd = true
	end
	
	opts.on('-r', '--rsync-options FILE', 'read file for additional rsync options') do |v|
		$rsync_option_file = v
	end

	opts.on('-m', '--mode MODE', 'specify backup mode') do |v|
		$backup_interval = v
	end

end

optparse.parse!

src_dir, bak_dir = ARGV

src_dir || abort('source dir is required')
bak_dir || abort('backup dir is required')
abort("source is not a directory") if not File.directory? src_dir

v "srcdir=#{src_dir}, back_dir=#{bak_dir}"

if not Dir.exist? bak_dir
	Dir.mkdir bak_dir
end

src_path = Pathname.new src_dir
bak_path = Pathname.new bak_dir

# find existing backup folders
all_bak_dirs = Dir.chdir(bak_dir) do
	Dir["#{src_path.basename}-*"].select{|p|File.directory? p}
end

projected_bak_dir = "#{src_path.basename}-#{get_projected_backup_dir()}"

if projected_bak_dir == all_bak_dirs[-1]
	current_bak_dir = projected_bak_dir
	link_dir = all_bak_dirs[-2]
else
	current_bak_dir = projected_bak_dir
	link_dir = all_bak_dirs[-1]
end

v "current_bak_dir=#{current_bak_dir}, link_dir=#{link_dir}"
full_current_bak_dir = "#{bak_dir}/#{current_bak_dir}"

src_dir = File.expand_path src_dir

if src_dir=~/^[a-z]:/i
	$use_pushd = true if not $use_pushd
	src_dir = src_dir.gsub(/^([a-z]):/i, '/cygdrive/\1')
end

src_dir = src_dir.gsub(/\\/, '/')

# prepare command lines

cmd = ''
cmd << "pushd #{full_current_bak_dir.gsub(/\//, '\\')}\n" if $use_pushd
cmd << "rsync -H -rt --chmod=ugo=rwX"

# read additional rsync options
if $rsync_option_file
	cmd << ' '
	cmd << File.open($rsync_option_file)
		.readlines()
		.reject{|line|line[0] != '-'}
		.map{|line|line.chomp} * ' '
end

cmd << " --link-dest=../#{link_dir}" if not link_dir.nil?
cmd << " #{src_dir}/"

if $use_pushd
	Dir.mkdir full_current_bak_dir if not Dir.exist? full_current_bak_dir
	cmd << " ."
else
	cmd << " #{bak_dir}/#{current_bak_dir}"
end

cmd << "\n"

cmd << "popd" if $use_pushd

if $output_file
	File.open($output_file, "w") {|out|
		out.puts cmd
	}
else
	puts cmd
end