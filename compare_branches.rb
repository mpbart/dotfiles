#!/usr/bin/env ruby

require 'set'
require 'optparse'


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} -- [options]"
  opts.on('-x', '--execute') { options[:force_execute] = true }
  opts.on('-d', '--dry-run') { options[:dry_run] = true }
  opts.on('-y', '--yes')     { options[:all_yes] = true }
  opts.on('-n', '--no')      { options[:all_no] = true }
end.parse!

# Remove stale branches still referencing origin before
# doing anything else
%x{git remote prune origin}

local = Set.new(
  %x{git branch}.
    split("\n").
    map(&:strip).
    map { |branch| branch.gsub('* ', '') }
)

remote = Set.new(
  %x{git branch -r | grep origin}.
    split("\n").
    map(&:strip).
    map { |branch| branch.gsub('origin/', '') }
)

merged = Set.new(
  %x{git branch --merged master}.
    split("\n").
    map(&:strip)
)

puts "Branches in Remote and Local:\n* #{(local & remote).sort.join("\n* ")}\n\n"

to_remove = (local - remote).map(&:strip).sort
puts "Local (Removable) Branches:" if to_remove.any?

removing = []
to_remove.each do |branch|
  if merged.include? branch
    puts "* #{branch} - Auto-Removing"
    removing << branch
    next
  end

  input = if options[:all_yes]
    puts "* #{branch} - Force Removing\n"
    'y'
  elsif options[:all_no]
    puts "* #{branch} - Keeping\n"
    'n'
  else
    print "* #{branch}: Remove (Y/n)? "
    gets.chomp.downcase
  end

  case input
  when 'exit'
   exit
  when 'revert', 'rollback', 'undo', 'r', 'u'
    removing.pop
    redo
  when 'status', 'info', 's', 'i'
    print "\n"
    operating_branch = %x{git branch | grep '* '}.gsub('* ', '')
    %x{git stash}
    %x(git checkout #{branch})
    puts %x(git status)
    %x(git checkout #{operating_branch})
    %x{git stash pop}
    redo
  else
    removing << branch if input != 'n'
  end
end

if removing.any?
  git_rm_cmd = "git branch -D #{removing.join(' ')}"
  puts git_rm_cmd

  input = if options[:force_execute]
    'y'
  elsif options[:dry_run]
    'n'
  else
    print 'Run this command? (Y/n) '
    gets.chomp.downcase
  end

  if input != 'n'
    puts IO.popen(git_rm_cmd).read
  end
end
