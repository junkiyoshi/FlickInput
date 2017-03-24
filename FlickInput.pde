import de.voidplus.leapmotion.*;

String _main_text;
Button[] btns;
Button btn_bs;

LeapMotion leap;
boolean finger_pressed;

void setup()
{
  size(512, 512);
  frameRate(30);
  rectMode(CENTER);
  textAlign(CENTER);
  
  PFont myFont = loadFont("AgencyFB-Bold-48.vlw");
  textFont(myFont);
  
  _main_text = "";
  
  int span = 110;
  
  btns = new Button[9];
  btns[0] = new Button(width / 2 - span, height / 2 - span, "", "A", "B", "C", "1");
  btns[1] = new Button(width / 2, height / 2 - span,        "", "D", "E", "F", "2");
  btns[2] = new Button(width / 2 + span, height / 2 - span, "", "G", "H", "I", "3");
  btns[3] = new Button(width / 2 - span, height / 2,        "", "J", "K", "L", "4");
  btns[4] = new Button(width / 2, height / 2,               "", "M", "N", "O", "5");
  btns[5] = new Button(width / 2 + span, height / 2,        "", "P", "Q", "R", "6");
  btns[6] = new Button(width / 2 - span, height / 2 + span, "@", "S", "T", "U", "7");
  btns[7] = new Button(width / 2, height / 2 + span,        "", "V", "W", "X", "8");
  btns[8] = new Button(width / 2 + span, height / 2 + span, "_", "Y", "Z", "0", "9");
  
  leap = new LeapMotion(this);
  finger_pressed = false;
}

void draw()
{
  background(255);
  
  fill(0);
  textSize(50);
  text(_main_text, width / 2, 80);
  
  for(int i = 0; i < btns.length; i++)
  {
    btns[i].display();
  }  
  
  for(Hand hand : leap.getHands())
  {
    if(hand.isRight())
    {
      Finger index_f = hand.getIndexFinger();
      PVector index_position = index_f.getPosition().copy();
      index_position.add(0, 100, 0);
      for(int i = 0; i < btns.length; i++)
      {
        btns[i].overCheck(index_position.x, index_position.y);
      }
      
      if(index_position.z > 50 && finger_pressed == false)
      {
        finger_pressed = true;
        for(int i = 0; i < btns.length; i++)
        {
          btns[i].pressedCheck(index_position.x, index_position.y);
        } 
      }
      
      if(index_position.z < 50 && finger_pressed == true)
      {
        finger_pressed = false;        
        for(int i = 0; i < btns.length; i++)
        {
          btns[i].released(index_position.x, index_position.y);
        } 
      }
      
      fill(0, 0, 200);
      ellipse(index_position.x, index_position.y, 10, 10);
      
      println("x = " + index_position.x + " y = " + index_position.y + " z = " + index_position.z);
    }
  }
}

void mousePressed()
{
  for(int i = 0; i < btns.length; i++)
  {
    btns[i].pressedCheck(mouseX, mouseY);
  }
}

void mouseReleased()
{
  for(int i = 0; i < btns.length; i++)
  {
    btns[i].released(mouseX, mouseY);
  }
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