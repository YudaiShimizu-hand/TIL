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

server.mount_proc("/form_get") do |req, res|
  body = "<html><meta charset='utf-8'><body>"
  body += "クエリパラメーターは#{req.query}です。"
  body += "こんにちは#{req.query['username']}さん"
  body += "あなたの年齢は#{req.query['age']}ですね"
  body += "</body></html>"
  res.status = 200
  res['content-type'] = "text/html"
  res.body = body
end

server.mount_proc("/form_post") do |req, res|
  body = "<html><meta charset='utf-8'><body>"
  body += "クエリパラメーターは#{req.query}です。"
  body += "こんにちは#{req.query['username']}さん"
  body += "あなたの年齢は#{req.query['age']}ですね"
  body += "</body></html>"
  res.status = 200
  res['content-type'] = "text/html"
  res.body = body
end






server.start