require 'webrick'

server = WEBrick::HTTPServer.new({ 
  :DocumentRoot => './',
  :BindAddress => '127.0.0.1',
  :Port => 8000
})

server.mount_proc '/users' do |req, res|
  File.open("index2.html") do |f|
    res.body = f.read
  end
end
server.mount('/users/taro.html', WEBrick::HTTPServlet::FileHandler, 'taro.html')
server.mount('/users/jiro.html', WEBrick::HTTPServlet::FileHandler, 'jiro.html')
server.mount('/users/saburo.html', WEBrick::HTTPServlet::FileHandler, 'saburo.html')




server.start