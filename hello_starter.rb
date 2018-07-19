require 'aws/decider'
require_relative 'utils'
require_relative 'hello_workflow'

#Gkkkkkkkkk
my_workflow_client = AWS::Flow.workflow_client(@swf.client, @domain) {
  {:from_class => "HelloWorldWorkflow"} }

puts "Starting an execution..."
workflow_execution = my_workflow_client.start_execution(
  "AWS Flow Framework for Ruby")

