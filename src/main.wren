import "graphics" for Canvas, Color, Font, ImageData
import "dome" for Window

class Title {
  construct new(x, y) {
    _x = x
    _y = y
    _image = ImageData.loadFromFile("res/title.png")
  }

  x { _x }
  x = (v) {
    _x = v
  }

  y { _y }
  y = (v) {
    _y = v
  }
  
  draw(dt) {
    Canvas.draw(_image, _x, _y)
  }
}

class Background {
  construct new() {
    _speed = 1

    // set image, x, y
    _layers = [
      [ImageData.loadFromFile("res/far-buildings.png"), 0, 0],
      [ImageData.loadFromFile("res/back-buildings.png"), 0, -20],
      [ImageData.loadFromFile("res/foreground.png"), 0, 50]
    ]
    
    // save images widths
    _layers[0].add(_layers[0][0].width)
    _layers[1].add(_layers[1][0].width)
    _layers[2].add(_layers[2][0].width)

    // save movement speeds
    _layers[0].add(-0.1 * _speed)
    _layers[1].add(-0.2 * _speed)
    _layers[2].add(-1 * _speed)
  }

  speed { _speed }
  speed = (v) {
    _speed = v
  }
  
  draw(dt) {
    _layers.each {|l|
      l[1] = (l[1] + (dt * l[4])) % l[3] 
      Canvas.draw(l[0], l[1], l[2])
      Canvas.draw(l[0], l[1] + l[3], l[2])
    }
  }
}

class Cat {
  construct new(x, y) {
    _image = ImageData.loadFromFile("res/cat.png")
    _speed = 0.1
    _x = x
    _y = y
    _frame = 0
    _animations = {
      "happy": 0,
      "excited": 1,
      "curious": 2,
      "lazy": 3,
      "sleepy": 4,
      "sad": 5,
      "runL": 6,
      "loading": 7,
      "error": 8
    }
    _current_animation = "runL"
  }

  x { _x }
  x = (v) {
    _x = v
  }

  y { _y }
  y = (v) {
    _y = v
  }

  animation { _current_animation }
  animation = (v) {
    _animation = v
  }

  speed { _speed }
  speed = (v) {
    _speed = v
  }
  
  draw(dt) {
    _frame = _frame + (_speed * dt)
    _image.drawArea((_frame.floor % 6) * 32, _animations[_current_animation] * 32, 32, 32, _x, _y)
  }
}

class Main {
  construct new() {
    // track the things I need to call draw() on
    _background = Background.new()
    _logo = Title.new((Canvas.width/2) - 79, -64)
    _cat = Cat.new((Canvas.width/2) - 16, Canvas.height - 40)

    _textY = (Canvas.height / 2)-20
    
    // how much time has passed
    _t = 0

    // where on the screen is the logo moving to?
    _logo_target = (Canvas.height/2) - 31 - 50

    // how fast?
    _logo_speed = 0.2
  }
  
  init() {
    Window.resize(320, 240)
    Window.title = "Pakémon"
    Window.lockstep = true
    Font.load("sans", "res/OpenSans-Regular.ttf", 12).antialias = true
  }

  update() {
    _t = _t + 1
    _alpha = (_t % 100) + 155
    if (_logo.y < _logo_target) {
      _logo.y = _logo.y + _logo_speed // move logo down
    }
  }

  draw(dt) {
    [_background, _logo, _cat].each {|d| d.draw(dt) }
    if (_t > 600) {
      Canvas.print("PRESS A BUTTON", 115, _textY, Color.rgb(255,255,255,_alpha), "sans")
    }
//     Canvas.print(Window.fps, 0, 0, Color.rgb(255,255,255,100))
  }
}

// this tells dome where to start
var Game = Main.new()