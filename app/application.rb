class Application
  @@items = [Item.new("Figs", 3.42), Item.new("Pears", 0.99)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      # This turns /items/Figs into Figs
      item = @@items.find { |i| i.name == item_name }

      # If the item is not found, then return a 400 and an error message
      if item
        resp.write item.price
      else
        resp.status = 400
        resp.write "Item not found"
      end
    else
      # Return 404 if a bad route
      resp.write "Route not found"
      resp.status = 404
    end

    resp.finish
  end
end