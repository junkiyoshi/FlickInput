class Button
{
  PVector location;
  float size = 100;
  String value1, value2, value3, value4, value5;
  color body_color;
  boolean over;
  boolean pressed;
  
  Button(float x, float y, String v1, String v2, String v3, String v4, String v5)
  {
    location = new PVector(x, y);
    value1 = v1;
    value2 = v2;
    value3 = v3;
    value4 = v4;
    value5 = v5;
    body_color = color(64);
    over = false;
    pressed = false;
  }
  
  void overCheck(float x, float y)
  {
    over = (location.x - size / 2 < x && x < location.x + size / 2 && location.y - size / 2 < y && y < location.y + size / 2) ? true : false;
  }
  
  void pressedCheck(float x, float y)
  {
    pressed = (location.x - size / 2 < x && x < location.x + size / 2 && location.y - size / 2 < y && y < location.y + size / 2) ? true : false;
  }
  
  void released(float x, float y)
  {
    if(pressed)
    {
      if(location.x - size / 2 < x && x < location.x + size / 2 && location.y - size / 2 < y && y < location.y + size / 2)
      {
        _main_text += (value1 != "") ? value1 : "";
      }else if(x < location.x + size / 2 && location.y - size / 2 < y && y < location.y + size / 2)
      {
        _main_text += (value2 != "") ? value2 : "";
      }else if(location.x - size / 2 < x && x < location.x + size / 2 && y < location.y + size / 2)
      {
        _main_text += (value3 != "") ? value3 : "";
      }else if(location.x - size / 2 < x && location.y - size / 2 < y && y < location.y + size / 2)
      {
        _main_text += (value4 != "") ? value4 : "";
      }else if(location.x - size / 2 < x && x < location.x + size / 2 && location.y - size / 2 < y)
      {
        _main_text += (value5 != "") ? value5 : "";
      }
    }
    pressed = false;
  }
  
  void display()
  {
    noStroke();
    
    if(pressed)
    {
      body_color = color(0, 128, 0);      
    }else if(over)
    {
      body_color = color(128);
    }else
    {
      body_color = color(64);
    }
    
    fill(body_color);
    rect(location.x, location.y, size, size);
    
    fill(255);
    textSize(size / 5);
    float x = location.x;
    float y = location.y + size / 10;
    
    text(value3, x, y - size / 3);
    text(value2 + "     " + value1 + "     " + value4, x, y);    
    text(value5, x, y + size / 3);
  }
}