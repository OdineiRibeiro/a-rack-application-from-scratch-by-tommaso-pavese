class Application
  def call(_env)
    ['200', { 'Content-Type' => 'text/html' }, ['Hello from the hackudom App!']]
  end
end
