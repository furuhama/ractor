# frozen_string_Literal: true

require 'socket'

t = Time.now
TRIAL = 10

rs = TRIAL.times.map do |i|
  Ractor.new name: "r#{i}" do
    puts "starting send request #{name}"
    sock = TCPSocket.open('localhost', 8080)

    begin
      puts sock.read
      puts "response received #{name}"
    ensure
      sock.close
    end
  end
end

rs.each(&:take)

puts "It takes #{Time.now - t} sec for #{TRIAL} requests"
