require 'aws/decider'

$RUBYFLOW_DECIDER_DOMAIN = "HelloWorld"
$TASK_LIST = "hello_world_task_list"

config_file = File.open('aws-config.txt') { |f| f.read } 
AWS.config(YAML.load(config_file))

@swf = AWS::SimpleWorkflow.new

begin

  @domain = @swf.domains[$RUBYFLOW_DECIDER_DOMAIN]
  @domain.status
rescue AWS::SimpleWorkflow::Errors::UnknownResourceFault => e
  @domain = @swf.domains.create($RUBYFLOW_DECIDER_DOMAIN, "10")
end


