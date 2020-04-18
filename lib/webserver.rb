# frozen_string_Literal: true

require 'socket'

class RactorTCPServer
  def initialize(port, worker_count)
    @port = port
    @worker_count = worker_count
  end

  def start
    server = TCPServer.new(@port)

    rs = init_workers(@worker_count)

    loop do
      puts 'start server loop'

      sock = server.accept

      r, _ = Ractor.select(*rs)
      r.send(sock, move: true) # Socket を渡すには :move オプションが必要
      puts "Sent socket to #{r.name}"
    end
  end

  private

  def init_workers(worker_count)
    worker_count.times.map do |i|
      Ractor.new name: "r#{i}" do
        loop do
          Ractor.yield 'ready' # ここで block, 外部から select されると進む

          sock = Ractor.recv
          begin
            sleep 1 # wait to simulate a heavy response
            sock.write 'accepted'
            puts "#{self.name}: respond"
          ensure
            sock.close
          end
        end
      end
    end
  end
end

server = RactorTCPServer.new(8080, 2)
puts 'starting RactorTCPServer ...'
server.start
