require "bunny"

class RmqConnection

  def connection(host = 'rabbitmq')
    @connection ||= Bunny.new :host => 'rabbitmq'
  end

  def initialize(queue_name)
    connection.start
    get_queue(queue_name)
    return self
  end

  def channel
    @channel ||= connection.create_channel
  end

  def get_queue(name, options = {})
    @queue ||= channel.queue(name, :durable => true)
  end

  def queue
    @queue ||= get_queue
  end

  def close
    connection.close
    connection = nil
  end


end
