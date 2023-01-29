import fisica.*;
FWorld world;

color stoneblock   = #000000;
color tree   = #00FF00;
color lavablock     = #FF0000;
color blue    = #0000FF;
color trampolineblock  = #F0A000;
color white   = #FFFFFF;
color iceblock    = #00FFFF;
color trunk   = #FF9500;
color spikeblock  = #6f3198;
color bridges    = #FF00FF;
color goombas  = #fff200;
color doorblock = #b5a5d5;
color wall    = #b4b4b4;
color thwomps = #990030;
color hammerguy = #004f00;
color bowsercolor = #a6e61d;
color fireballblock = #546d8e;

Button play, Restart, normalmap, bossmap;
int limit = 2000;
int seconds;
int bowserlives = 3;

boolean wkey, akey, skey, dkey, upkey, downkey, rightkey, leftkey, spacekey, invincibility, mouseReleased, wasPressed, bossON;
int f, x, y;
PFont MilkyCoffee;
Gif[] myGifs = new Gif[1];

final int map0 = 0;
final int map1 = 1;
final int nomap = 2;
boolean level = true;

int mode;
final int INTRO = 0;
final int PLAY = 1;
final int GAMEOVER = 2;

FPlayer player;
ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

PImage level1, ice, stone, treeTrunk, treeIntersect, treeEndWest, treeEndEast, spike, treeMiddle, bridge, trampoline, heart, hammer, level2, bowser, door, MAP1, MAP2, fireball;
int gridSize = 32;
float zoom = 0.5;

PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] lava;
PImage[] thwomp;
PImage[] hammerbro;

void setup() {
  size(600, 600);
  Fisica.init(this);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();
  loadImages();
  play = new Button("START", width/2, 3*height/4, 200, 100, white, stoneblock);

  Restart = new Button("RESTART", width/2, 400, 120, 80, white, trampolineblock);

  normalmap = new Button(MAP1, width/6*2-60, 400, 200, 200, white, stoneblock);
  bossmap = new Button(MAP2, width/6*4+ 60, 400, 200, 200, white, stoneblock);
  mode = INTRO;
  level = true;
  MilkyCoffee = createFont("MilkyCoffee.ttf", 1);
  myGifs[0] = new Gif("introgif/frame_", "_delay-0.03s.gif", 53, 1, width/2, height/2, width, height);
  level = true;

}
void loadImages() {
  level1 = loadImage("drawing.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  ice.resize(32, 32);
  stone = loadImage("brick.png");
  treeIntersect = loadImage("tree_intersect.png");
  treeMiddle = loadImage("treetop_center.png");
  treeEndWest = loadImage("treetop_w.png");
  treeEndEast = loadImage("treetop_e.png");
  spike = loadImage("spike.png");
  bridge = loadImage("bridge_center.png");
  trampoline = loadImage("trampoline.png");
  heart = loadImage("heart.png");
  hammer = loadImage("hammer.png");
  level2 = loadImage("bosslevel.png");
  bowser = loadImage("bowser.png");
  bowser.resize(500, 500);
  door = loadImage("door.png");
  door.resize(32, 32);
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  action = idle;

  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize, gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize, gridSize);

  lava = new PImage[6];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  lava[4] = loadImage("lava4.png");
  lava[5]= loadImage("lava5.png");

  fireball = loadImage("fireball.png");
  fireball.resize(64, 64);

  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[1] = loadImage("thwomp1.png");

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[1] = loadImage("hammerbro1.png");

  MAP1 = loadImage("map1button.png");
  MAP2 = loadImage("bosslevelimage.png");
}

void loadWorld(PImage img) {
  world = new FWorld(-100, -1000, 2201, 2201);
  world.setGravity(0, 900);
  for (int y = 0; y <img.height; y++) {
    for (int x = 0; x < img.width; x++) {
      color c  = img.get(x, y);
      color s = img.get(x, y+1);
      color w = img.get(x-1, y);
      color e = img.get(x+1, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize-100);
      b.setStatic(true);
      if (c == stoneblock) {
        b.attachImage(stone);
        b.setFriction(10);
        b.setName("stone");
        world.add(b);
      } else if (c == wall) {
        b.attachImage(stone);
        b.setName("wall");
        b.setFriction(10);

        world.add(b);
      } else if (c == iceblock) {
        b.attachImage(ice);
        b.setFriction(-4);
        world.add(b);
      } else if (c == trunk) {
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("tree trunk");
        world.add(b);
      } else if (c == tree && s == trunk) {
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
        b.setFriction(10);
      } else if (c == tree && w == tree & e == tree) {
        b.attachImage(treeMiddle);
        b.setName("treetop");
        world.add(b);
      } else  if (c ==tree && w != tree) {
        b.attachImage(treeEndWest);
        b.setName("treetop");
        world.add(b);
      } else if (c == tree && e != tree) {
        b.attachImage(treeEndEast);
        b.setName("treetop");
        world.add(b);
      } else if (c==spikeblock) {
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
        b.setFriction(10);
      } else if (c==bridges) {
        FBridge br = new FBridge(x*gridSize, y*gridSize-100);
        terrain.add(br);
        world.add(br);
        b.setFriction(10);
      } else if (c == goombas) {
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize-100);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == lavablock) {
        b.setFriction(10);
        FLava lv = new FLava(x*gridSize, y*gridSize-100);
        terrain.add(lv);
        world.add(lv);
      } else if (c == trampolineblock) {
        b.attachImage(trampoline);
        b.setName("trampoline");
        world.add(b);
        b.setRestitution(2.5);
      } else if (c == thwomps) {
        FThwomp tp = new FThwomp(x*gridSize, y*gridSize-100);
        enemies.add(tp);
        world.add(tp);
      } else if (c == hammerguy) {
        FHammerBro hb = new FHammerBro(x*gridSize, y*gridSize-100);
        enemies.add(hb);
        world.add(hb);
      } else if (c == bowsercolor) {
        FBowser bow = new FBowser(x*gridSize, y*gridSize-100);
        enemies.add(bow);
        world.add(bow);
        println(bow.lives, seconds);
      } else if ( c== doorblock) {
        b.attachImage(door);
        b.setName("door");
        world.add(b);
      } else if (c == fireballblock) {
        FFireball fb = new FFireball(x*gridSize, y*gridSize-100);
        enemies.add(fb);
        world.add(fb);
      }
    }
  }
}
void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void draw() {
  click();
  textFont(MilkyCoffee, 10);

  println(bowserlives, seconds);

  changeGamemodes();
}

void addBLock(FBox b, ArrayList list, String name) {
  world.add(b);
  list.add(b);
  b.setName(name);
}

void actWorld() {
  player.act();
  for (int i = 0; i<terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
  for (int i = 0; i < enemies.size(); i++) {
    FGameObject e = enemies.get(i);
    e.act();
  }
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+300, -player.getY()*zoom+300);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}

void drawLives() {
  if (player.lives == 3) {
    image(heart, x+25, y+25);
    image(heart, x+60, y+25);
    image(heart, x+95, y+25);
  }
  if (player.lives == 2) {
    image(heart, x+25, y+25);
    image(heart, x+60, y+25);
  }
  if (player.lives == 1) {
    image(heart, x+15, y+25);
  }
}

void loadBLocks(PImage block, String name, FBox a) {
  FBox b = new FBox(gridSize, gridSize);
  b.attachImage(block);
  b.setName(name);
  world.add(a);
}

void changeGamemodes() {
  if (mode == INTRO) intro();
  if (mode == PLAY) {
    background(stoneblock);
    drawWorld();
    actWorld();
    drawLives();
  }
  if (mode == GAMEOVER) gameover();
}
