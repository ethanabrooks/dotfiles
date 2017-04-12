require 'pathname'
require 'optparse'
require 'set'

options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: sync_to_gpu.rb [options]'

  opts.on('--exclude x,y,z', Array, 'list of files to exclude') do |v|
    options[:exclude] = v
  end
end.parse!


root = Pathname.pwd
dockerfile = root + 'Dockerfile'
until root == '/' or dockerfile.exist?
  root = root.parent
  dockerfile = root + 'Dockerfile'
end

p dockerfile

universal_excludes = %w(\.git \.idea)
unless options[:exclude].nil?
  universal_excludes += options[:exclude]
end
local_excludes = []
exclude_paths = []

root.find do |path|
  if path.basename.to_s == '.gitignore'
    File.open(path) do |f|
      f.each_line do |gitignored|
        local_excludes << (path.dirname + gitignored).to_s.strip
      end
    end
  end
end

root.find do |path|
  if universal_excludes.any? do |pattern|
      path.basename.to_s =~ /#{pattern}/
    end or local_excludes.any? do |pattern|
      path.to_s =~ /#{pattern}/
  end
    exclude_paths << path
  else
    p path
  end
end

# exclude_paths.each { |x| p x }


