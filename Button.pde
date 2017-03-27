class Button
{
  PVector location;
  float size = 100;
  String[] values = {"", "", "", "", ""};
  color body_color;
  boolean over;
  boolean pressed;
  
  Button(float x, float y, String v0, String v1, String v2, String v3, String v4)
  {
    location = new PVector(x, y);
    values[0] = v0;
    values[1] = v1;
    values[2] = v2;
    values[3] = v3;
    values[4] = v4;
    body_color = color(64);
    over = false;
    pressed = false;
  }
  
  boolean overCheck(float x, float y)
  {
    over = (location.x - size / 2 < x && x < location.x + size / 2 && location.y - size / 2 < y && y < location.y + size / 2) ? true : false;
    return over;
  }
  
  boolean pressedCheck(float x, float y)
  {
    pressed = (location.x - size / 2 < x && x < location.x + size / 2 && location.y - size / 2 < y && y < location.y + size / 2) ? true : false;
    return pressed;
  }
  
  void released(float x, float y)
  {
    if(pressed)
    {
      float span_size = 10;
      PVector[] points = {new PVector(location.x, location.y), new PVector(location.x - size - span_size, location.y),
                          new PVector(location.x, location.y - size - span_size), new PVector(location.x + size + span_size, location.y),
                          new PVector(location.x, location.y + size + span_size)};
                          
     for(int i = 0; i < points.length; i++)
     {
        if(values[i] != "")
        {
          if(points[i].x - size / 2 < x && x < points[i].x + size / 2 && points[i].y - size / 2 < y && y < points[i].y + size / 2)
          {
            _main_text += values[i];
          }
        }
      }     
    }
    pressed = false;
  }
  
  void display()
  {
    noStroke();
    
    body_color = (over) ? color(128) : color(64);
    fill(body_color);
    rect(location.x, location.y, size, size);
    
    fill(255);
    textSize(size / 4);
    float x = location.x;
    float y = location.y + size / 10;
    
    if(values[3] == "")
    {
      text(values[0] + " " + values[1] + " " + values[2], x, y);
    }else
    {
      text(values[0] + " " + values[1] + " " + values[2] + " " + values[3], x, y);
    }
    text(values[4], x, y + size / 3);
  }
}