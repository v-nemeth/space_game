
def init args
  args.grid.origin_center!
  args.state.hex_size ||= 100
  args.state.grid_size = 10
  build_grid args
end


def build_grid args
  g_size = args.state.grid_size

  for q in -g_size..g_size
    for r in -g_size..g_size
      render_hex args, q, r if !(q+r > g_size or q+r < -g_size)
    end
  end
end

#Render hex in grid
def render_hex args, x, y, opacity = 100, color = "black"
  y = -y
  args.outputs.sprites << [ ( x * Math.sqrt(3) * args.state.hex_size * 1/2 ) - (y * (args.state.hex_size-13)/2) - args.state.hex_size/2,
                           y*(3/4*args.state.hex_size) - args.state.hex_size/2,
                           args.state.hex_size,
                           args.state.hex_size,
                            "sprites/hexagon/#{color}.png", 0,opacity]
end

def abs(int)
  Math.sqrt(int**2)
end

def pix_to_grid x_px, y_px

  y = -( (y_px+53)/(3/4*100) ).floor

  x = ( (x_px+50)/(Math.sqrt(3) * 100 * 1/2) - y/2 ).floor

  [x,y]
end

def tick args
  init args

  args.state.visible ||= false


  if Math.sqrt(args.inputs.mouse.x**2+args.inputs.mouse.y**2) < args.state.hex_size/2
    args.state.visible = true
  else
    args.state.visible = false
  end

  render_hex args,0,0 if args.state.visible

  args.state.mouse_pos ||= [0,0]
  args.state.mouse_pos = pix_to_grid(args.inputs.mouse.x,args.inputs.mouse.y)
  render_hex args, args.state.mouse_pos[0], args.state.mouse_pos[1]

end
