#!/usr/bin/env ruby

class Node

	attr_accessor :id, :text, :parent, :children, :rank, :rank_category
	
	def initialize(id='', text='/', parent=nil, rank='0', rank_category=nil)
		@id = id
		@text = text
		@parent = parent
		@children = []
		@rank = rank.to_i
		@rank_category = rank_category || ''
	end
end


$root = Node.new()
$nodes = {}
$screen_width = 100

def print_node(indent, head, node, more_siblings)
	text = node.id + ' ' + node.text
	width = $screen_width - indent.length
	if text.length > width
		r = Regexp.new(".{1,#{width}}")
		secondary_indent = nil
		text.scan(r) do |line|
			if secondary_indent
				puts "#{indent}#{secondary_indent}#{line}"
			else
				puts "#{indent}#{head}#{line}"
				secondary_indent = (more_siblings ? head[0].chr : ' ').ljust(head.length) + (node.children.length>0 ? '|' : ' ').ljust(node.id.length+1)
			end
		end
	else
		puts "#{indent}#{head}#{text}"
	end
end

def pptree(indent = '', node = $root)
	
	# puts indent + " children: " + (node.children.map{|n| n.id})*', '
	children = node.children.sort {|a,b|
		rc = a.rank_category <=> b.rank_category
		rc != 0 ? rc : a.rank <=> b.rank
	}

	last = children.pop
	
	children.each do |n|
		print_node indent, '|--', n, true
		pptree(indent + "|  ", n)
	end
	
	if !last.nil?
		print_node indent, '`--', last, false
		pptree(indent + '   ', last)
	end
end

ARGF.each do |line|
	
	id, text, parent, rank, rank_category = line.chomp.split "\t"
	
	n = $nodes[id]
	if n.nil?
		$nodes[id] = n = Node.new(id, text, parent, rank, rank_category)
	else
		n.text = n.text + ' ' + text
	end
end

$nodes.each_pair do |k, n|
	#puts "processing #{k}: #{n.text}"
	($nodes[n.parent] || $root).children.push n
	#print_node "  p->", ($nodes[n.parent] || $root)
end

pptree