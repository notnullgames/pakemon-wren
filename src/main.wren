import "graphics" for Canvas, Color, Font
import "dome" for Window

class Logo {
  static init() {}

  static update() {}
  
  static draw(dt) {}
}


class Cat {
  static init() {}

  static update() {}
  
  static draw(dt) {}
}


class Background {
  static init() {}

  static update() {}
  
  static draw(dt) {}
}

class Game {
    static init() {
      Window.resize(320, 240)
      Window.title = "Pakémon"
    }

    static update() {}
    
    static draw(dt) {
      Canvas.print("DOME Installed Successfully.", 10, 10, Color.white)
    }
}
