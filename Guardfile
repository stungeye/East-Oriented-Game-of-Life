# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(/^spec\/.+_spec.rb$/)
  watch('spec/spec_helper.rb') { 'spec' }
  watch(/^lib\/(.+)\.rb$/) { |m| "spec/#{m[1]}_spec.rb" }
end

guard :rubocop, cli: ['-c', 'rubocop.yml'] do
  watch(/.+\.rb$/)
end
