import "graphics" for Canvas, Color, Font, ImageData
import "dome" for Window

class Title {
  construct new() {
    _image = ImageData.loadFromFile("res/title.png")
    _x = (Canvas.width / 2) - (_image.width / 2)
    _y = -1 * _image.height
    _ytarget = (Canvas.height / 2) - (_image.height / 2) - 40
    _speed = 0.4
  }
  
  draw(dt) {
    if (_y < _ytarget) {
      _y = _y + dt * _speed
    }
    Canvas.draw(_image, _x, _y)
  }
}

class Background {
  construct new() {
    // set image, x, y
    _layers = [
      [ImageData.loadFromFile("res/far-buildings.png"), 0, 0],
      [ImageData.loadFromFile("res/back-buildings.png"), 0, -20],
      [ImageData.loadFromFile("res/foreground.png"), 0, 50]
    ]
    
    // set images widths
    _layers[0].add(320)
    _layers[1].add(320)
    _layers[2].add(352)

    // set movement speeds
    _layers[0].add(-0.1)
    _layers[1].add(-0.2)
    _layers[2].add(-1)
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
  construct new() {
    _image = ImageData.loadFromFile("res/cat.png")
    _speed = 0.1
    _x = Canvas.width / 2
    _y = Canvas.height - 40
    _frame = 0
    _offsetY = 6 * 32
  }
  
  draw(dt) {
    _frame = _frame + (_speed * dt)
    _image.drawArea((_frame.floor % 6) * 32, _offsetY, 32, 32, _x, _y)
  }
}

class Main {
  construct new() {
    // track the things I need to call draw() on
    _drawables = []
    _drawables.add(Background.new())
    _drawables.add(Title.new())
    _drawables.add(Cat.new())
    _t = 0
  }
  
  init() {
    Window.resize(320, 240)
    Window.title = "Pakémon"
    Window.lockstep = true
  }

  update() {
    _t = _t + 1
    _alpha = (_t % 155) + 100
  }

  draw(dt) {
    Canvas.cls()
    _drawables.each {|d| d.draw(dt) }
    if (_t > 300) {
      Canvas.print("PRESS ANY KEY", 110, (Canvas.height / 2), Color.rgb(255,255,255,_alpha))
    }
  }
}

// this tells dome where to start
var Game = Main.new()