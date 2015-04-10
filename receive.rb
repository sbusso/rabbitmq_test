#!/usr/bin/env ruby
# encoding: utf-8

require_relative "rmq_connection"

rmq = RmqConnection.new("task_queue")

rmq.channel.prefetch(1)

puts " [*] Waiting for messages. To exit press CTRL+C"

begin
  rmq.queue.subscribe(:manual_ack => true, :block => true) do |delivery_info, properties, body|
    puts " [x] Received '#{body}'"
    # imitate some work
    puts " [x] Done"
    rmq.channel.ack(delivery_info.delivery_tag)
  end
rescue Interrupt => _
  rmq.close
end
