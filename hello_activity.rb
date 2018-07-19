require_relative 'utils'

class HelloWorldActivity
  extend AWS::Flow::Activities

  activity :hello_activity, :my_hello do
    {
      :default_task_list => $TASK_LIST, :version => "my_first_activity",
      :default_task_schedule_to_start_timeout => 30,
      :default_task_start_to_close_timeout => 30
    }
  end

  def hello_activity(name)
    puts "Hello, #{name}!"
  end

end


activity_worker = AWS::Flow::ActivityWorker.new(
  @swf.client, @domain, $TASK_LIST, HelloWorldActivity)

# Start the worker if this file is called directly
# from the command line. 
activity_worker.start if __FILE__ == $0
