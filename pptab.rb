#!/usr/bin/env ruby

require 'optparse'

options = {
	:separater => "\t",
	:formatfile => 'pptab-format.txt',
}

optparse = OptionParser.new do |opts|
	opts.banner = 'Usage: pptab [options] files'
	
	opts.on('-h', '--help', 'display this screen') do
		puts opts
		exit
	end
	
	opts.on('-s', '--separater S', 'specify input separater, default is tab') do |s|
		options[:separater] = s
	end
	
	opts.on('-f', '--format FILE', 'specify format file') do |file|
		options[:formatfile] = file
	end
	
	opts.on('-o', '--output FILE', 'output to file instead of stdout') do |file|
		options[:output] = file
	end
end

optparse.parse!

$text_format = {}
$pattern_format = []

def find_width(head)
	width = $text_format[head.downcase]
	return width if width
	$pattern_format.each_index do |i|
		f = $pattern_format[i]
		regex = f[:re] || f[:re] = Regexp.new(f[:pattern], true)
		return f[:width] if regex.match(head)
	end
	return nil
end

def parse_format(arg)
	if arg =~ /(\S+)\s*=\s*(\d+)/
		pattern, width = $1, $2
		if pattern =~ /^[\w#]+$/
			$text_format[pattern.downcase] = width.to_i
		elsif
			$pattern_format.push({:pattern => pattern, :width=> width.to_i})
		end
	end
end

ARGV.delete_if {|arg| parse_format(arg) }

if File.exist? options[:formatfile]
	File.open(options[:formatfile], 'r') do |f|
		while line = f.gets
			parse_format(line)
		end
	end
end

#ARGV.each do |arg|
#	puts 'unparsed ' + arg
#end

field_count = 0
field_width = []

outf = options[:output] ? File.new(options[:output], 'w') : STDOUT

ARGF.each do |line|
	
	line.chomp!
	
	if line.start_with?('--') || line.length == 0
		outf.puts line
		field_count = 0
		next
	end
	
	fields = line.split(options[:separater])
	is_header = false
	if fields.length != field_count
		if line =~ /^[\w\s]+$/
			fields.each_index do |i|
				field_width[i] = find_width(fields[i]) || fields[i].length
			end
			is_header = true
			field_count = fields.length
		else
			abort "header row pattern is not detected while trying to parse header\n  line #{$.}: #{line}"
		end
	end

	fields.each_index do |i|
		if fields[i].length > field_width[i]
			if field_width[i] > 3
				text = fields[i][0, field_width[i] - 3] + '...'
			elsif
				text = fields[i][0, field_width[i]]
			end
		elsif
			text = fields[i].rjust(field_width[i], is_header ? '=' : ' ')
		end
		
		outf.print ' ' if i > 0
		outf.print text
	end
	
	outf.puts
	
end

outf.close if outf != STDOUT
