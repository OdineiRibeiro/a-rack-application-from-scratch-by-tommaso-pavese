class Router
  def initialize(request)
    @request = request
  end

  def route!
    if klass = controller_class
      add_route_info_to_requested_params!

      controller  = klass.new @request
      action      = route_info[:action]

      if controller.respond_to? action
        puts "\nRouting to #{klass}\##{action}"
        return controller.public_send action
      end
    end

    not_found
  end

  def not_found(msg = 'Not found :(')
    [200, { 'Content-Type' => 'text/plain' }, [msg]]
  end

  private

  def add_route_info_to_requested_params!
    @request.params.merge! route_info
  end

  def controller_name
    "#{route_info[:resource].capitalize}Controller"
  end

  def controller_class
    Object.const_get controller_name
  rescue NameError
    nil
  end

  def route_info
    @route_info ||= begin
      resource = path_fragments[0] || 'base'
      id, action = find_id_and_action(path_fragments[1])
      { resource: resource, action: action, id: id }
    end
  end

  def find_id_and_action(fragment)
    case fragment
    when 'new'
      [nil, :new]
    when nil
      action = @request.get? ? :index : :create
      [nil, action]
    else
      [fragment, :show]
    end
  end

  def path_fragments
    @fragments ||= @request.path.split('/').reject(&:empty?)
  end
end
