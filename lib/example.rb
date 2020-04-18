# frozen_string_Literal: true

r1 = Ractor.new name: :r1 do
  puts 42
  sleep 1
  puts self

  msg = Ractor.recv
  puts msg

  'return value'
end

r2 = Ractor.new name: :r2 do
  puts 44
  sleep 1
  puts self

  raise 'r2 error'
end

puts r1.name
puts r2.name

r1.send 'message from outside'

puts r1.take

begin
  r2.take
rescue Ractor::RemoteError => e
  puts e.cause.class
  puts e.cause.message
  puts e.ractor
end

puts 'end'
