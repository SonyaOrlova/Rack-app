require_relative 'services/time_parser' 

class App
  def call(env)
    req = Rack::Request.new(env)

    if req.get? && req.path.match('/time')
      time(req.params)
    else
      resp('Not found', 404)
    end
  end

  private

  def resp(body, status)
    Rack::Response.new(body, status).finish
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def time(params)
    time_parser = TimeParser.new(params['format'])
    time_parser.call

    if time_parser.success?
     resp(time_parser.time_result, 200)
   else
     resp(time_parser.error_msg, 400)
   end
  end
end
