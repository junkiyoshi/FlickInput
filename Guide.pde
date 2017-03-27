class Guide
{
  PVector location;
  float size;
  String[] values = {"", "", "", "", ""};
  boolean visible;
  
  Guide()
  {
    location = new PVector(0, 0);
    size = 100;
    visible = false;
  }
  
  void setLocation(float x, float y)
  {
    location = new PVector(x, y);
  }
  
  void setStrings(String[] v)
  {
    values[0] = v[0];
    values[1] = v[1];
    values[2] = v[2];
    values[3] = v[3];
    values[4] = v[4];
  }
  
  void display(float x, float y)
  {
    if(visible)
    {
      color rect_color = color(0, 192, 192);
      color selected_color = color(224, 64, 0);
      color char_color = color(0);
      float text_size = size / 2;
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
            fill(selected_color);
          }
          else
          {
            fill(rect_color);
          }
          rect(points[i].x, points[i].y, size, size); 
          fill(char_color);
          textSize(text_size);
          text(values[i], points[i].x, points[i].y + text_size / 2);
        }
      }
    }
  }
}