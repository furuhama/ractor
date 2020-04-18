# frozen_string_Literal: true

require 'socket'

rs = 2.times.map do |i|
  Ractor.new name: "r#{i}" do
    Ractor.yield 'ready' # ここで block, 外部から select されると進む

    sock = Ractor.recv
    begin
      sock.write 'accepted'
      puts "#{self.name}: respond"
    ensure
      sock.close
    end

    'end'
  end
end

Socket.tcp_server_loop(8080) do |sock, client_addrinfo|
  puts 'start server loop'

  r, _ = Ractor.select(*rs)
  r.send(sock) #=> <internal:ractor>:100:in `send': can't dump Socket (TypeError)
  puts "Sent socket to #{r.name}"
end

puts 'exit'
