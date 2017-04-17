class BaseController
  attr_reader :request

  def initialize(request)
    @request = request
  end

  def index
    body =
      <<~HTML
        <html>
          <head><title>A Rack Demonho</title></head>
          <body>
            <h1>This is the root page</h1>
            <p>Hello from a controller!</p>
          </body>
        </html>
      HTML
    build_response body
  end

  private

  def build_response(body, status: 200)
    [status, { 'Content-Type' => 'text/html' }, [body]]
  end

  def redirect_to(uri)
    [302, { 'Location' => uri }, []]
  end

  def params
    request.params
  end
end
