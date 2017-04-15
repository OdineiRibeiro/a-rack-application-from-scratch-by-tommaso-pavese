class Router
  def initialize(request)
    @request = request
  end

  def route!
    if @request.path == '/'
      [200, { 'Content-Type' => 'text/plain' }, ['Hello from the router!']]
    else
      not_found
    end
  end

  def not_found(msg = 'Not found :(')
    [200, { 'Content-Type' => 'text/plain' }, [msg]]
  end
end
