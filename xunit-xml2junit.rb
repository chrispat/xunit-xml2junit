require 'rubygems'
gem 'builder', '~> 3.2.2'
gem 'oga', '~> 2.0.0'
require 'builder'
require 'oga'

$stderr.puts 'This script will generate a junit'\
' xml file from a xunit test report.'
$stderr.puts 'Usage:
  ruby xunit-xml2junit.rb input.xml
  '

if ARGV.length == 0
  $stderr.puts 'No input xml file given.'
  exit 1
end

input_path = ARGV[0]
unless File.exist?(input_path)
  $stderr.puts "No such xml file: #{input_path}"
  exit 1
end

builder = Builder::XmlMarkup.new(target: STDOUT, indent: 2)
file = File.open(input_path)
doc = Oga.parse_xml(file)
tests = doc.xpath('//test')
builder.testsuite(tests: tests.count) do |testsuite|
  tests.each do |test_node|
    type = test_node.get('type')
    name = test_node.get('method')
    time = test_node.get('time')
    testsuite.testcase(classname: type, name: name, time: time) do |test|
      err_node = test_node.css('failure').first
      unless err_node.nil?
        message = err_node.css('message').text
        message += "\r\n" + err_node.css('stack-trace').text
        type = err_node.get('exception-type')
        test.failure(type: type) do |failure|
          failure.cdata! message
        end
      end
    end
  end
end
builder.target!
