#!/usr/bin/env ruby
# encoding: utf-8

require_relative "rmq_connection"

rmq = RmqConnection.new "task_queue"

1.upto(20).each do |i|
  msg  = ARGV.empty? ? "Hello World! #{i}" : ARGV.join(" ")

  rmq.queue.publish(msg, :persistent => true)
  puts " [x] Sent #{msg}"
end
rmq.close
