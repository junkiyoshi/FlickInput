import de.voidplus.leapmotion.*;

String _main_text;
Button[] btns;
Button btn_bs;
Guide guide;

LeapMotion leap;
PVector finger_position;
boolean finger_pressed;

void setup()
{
  size(600, 600);
  frameRate(30);
  rectMode(CENTER);
  textAlign(CENTER);
  
  PFont myFont = loadFont("AgencyFB-Bold-48.vlw");
  textFont(myFont);
  
  _main_text = "";
  
  int span = 110;
  
  btns = new Button[9];
  btns[0] = new Button(width / 2 - span, height / 2 - span, ".", "@", "-", "_", "1");
  btns[1] = new Button(width / 2, height / 2 - span,        "A", "B", "C", "", "2");
  btns[2] = new Button(width / 2 + span, height / 2 - span, "D", "E", "F", "", "3");
  btns[3] = new Button(width / 2 - span, height / 2,        "G", "H", "I", "", "4");
  btns[4] = new Button(width / 2, height / 2,               "J", "K", "L", "", "5");
  btns[5] = new Button(width / 2 + span, height / 2,        "M", "N", "O", "", "6");
  btns[6] = new Button(width / 2 - span, height / 2 + span, "P", "Q", "R", "S", "7");
  btns[7] = new Button(width / 2, height / 2 + span,        "T", "U", "V", "", "8");
  btns[8] = new Button(width / 2 + span, height / 2 + span, "W", "X", "Y", "Z", "9");
  
  guide = new Guide();
  
  leap = new LeapMotion(this);
  finger_position = new PVector(0, 0);
  finger_pressed = false;
}

void draw()
{
  background(255);
  
  fill(0);
  textSize(60);
  text(_main_text, width / 2, 80);
  
  for(int i = 0; i < btns.length; i++)
  {
    btns[i].display();
  }  
  
  guide.display(finger_position.x, finger_position.y);
    
  for(Hand hand : leap.getHands())
  {
    if(hand.isRight())
    {
      Finger index_f = hand.getIndexFinger();
      PVector index_position = index_f.getPosition().copy();
      index_position.add(0, 0, 0);
      for(int i = 0; i < btns.length; i++)
      {
        btns[i].overCheck(index_position.x, index_position.y);
      }
      
      if(index_position.z > 50 && finger_pressed == false)
      {
        finger_pressed = true;
        for(int i = 0; i < btns.length; i++)
        {
          if(btns[i].pressedCheck(index_position.x, index_position.y))
          {
            guide.setLocation(btns[i].location.x, btns[i].location.y);
            guide.setStrings(btns[i].values);
            guide.visible = true;
          }
        } 
      }
      
      if(index_position.z < 50 && finger_pressed == true)
      {
        finger_pressed = false;        
        for(int i = 0; i < btns.length; i++)
        {
          btns[i].released(index_position.x, index_position.y);
        } 
        guide.visible = false;
      }
      
      finger_position = index_position.copy();
      
      if(index_position.z > 50)
      {
        stroke(0, 0, 200);
      }else{
        stroke(200, 0, 0);
      }
      noFill();
      ellipse(index_position.x, index_position.y, index_position.z, index_position.z);
    }
  }  
}

void mousePressed()
{
  for(int i = 0; i < btns.length; i++)
  {
    if(btns[i].pressedCheck(mouseX, mouseY))
    {
      guide.setLocation(btns[i].location.x, btns[i].location.y);
      guide.setStrings(btns[i].values);
      guide.visible = true;
    }
  }
}

void mouseReleased()
{
  for(int i = 0; i < btns.length; i++)
  {
    btns[i].released(mouseX, mouseY);
  }
  
  guide.visible = false;
}

void keyTyped()
{
  if(key == BACKSPACE)
  {
    if(_main_text.length() > 0)
    {
      _main_text = _main_text.substring(0, _main_text.length() - 1);
    }
  }
  
  for(int i = 0; i < btns.length; i++)
  {
    btns[i].released(0, 0);
  }
}