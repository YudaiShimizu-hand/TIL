require 'webrick'

server = WEBrick::HTTPServer.new({ 
  :DocumentRoot => './',
  :BindAddress => '127.0.0.1',
  :Port => 8000
})

server.mount_proc("/time") do |req, res|
    body = "<html><body>"
    body += "#{Time.new}"
    body += "</body></html>"
    res.status = 200
    res['content-type'] = "text/html"
    res.body = body
end

server.start