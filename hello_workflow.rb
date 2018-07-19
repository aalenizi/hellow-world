require_relative 'utils'
require_relative "./hello_activity"

class HelloWorldWorkflow
  extend AWS::Flow::Workflows

  workflow :hello_workflow do
    {
      :version => "1",
      :task_list => $TASK_LIST,
      :execution_start_to_close_timeout => 3600
    }
  end

  activity_client(:activity) { {:from_class => "HelloWorldActivity"} }

  def hello_workflow(name)
    activity.hello_activity(name)
  end
end

worker = AWS::Flow::WorkflowWorker.new(
  @swf.client, @domain, $TASK_LIST, HelloWorldWorkflow)

# Start the worker if this file is called directly
# from the command line. 
worker.start if __FILE__ == $0


