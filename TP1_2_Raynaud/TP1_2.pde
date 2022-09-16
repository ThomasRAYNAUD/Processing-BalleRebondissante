/*
1) Écrivez un sketch mettant en scène une balle (« balle.png ») chutant 
verticalement du milieu de la fenêtre et rebondissant sur le sol. À chaque 
rebond, la balle atteint une altitude de plus en plus basse, jusqu'à devenir
immobile (Vous diviserez par 2, ou bien par 3, la hauteur de 2 rebonds successifs).

2) Jouez un son au moment de la collision avec le sol :
  a) Installez la librairie permettant de jouer du son :
    Sketch > importer une librairie > ajouter une librairie :
    Installez la librairie « Sound » de « The Processing Foundation ».
  b) Importez la librairie dans votre sketch en écrivant en haut du programme :
    import processing.sound.* ;
  c) Pour lire un son :
    // chargez le fichier son (qui est dans data/ du répertoire du sketch)  
    SoundFile sound = new SoundFile(this, dataPath("bounce.mp3"));  
    // jouez le son
    sound.play() ;
    
3) Ajouter la possibilité de définir la position initiale de la balle à l'aide de 
la souris, avant de lâcher la balle (« drag and drop »). Utilisez les fonctions 
« mousePressed », « mouseDragged » and « mouseReleased ».

4) Ajoutez une deuxième balle (sans gestion des collisions entre balles).

5) En quoi la définition et l'utilisation d'une classe « Balle » réduit la longueur
et la complexité du programme facilitant ainsi l'ajout de plusieurs balles ?
*/
//déclaration des variables gloables:
//déclarer la variable img de type PImage(type de donnéespour stocker image
PImage img;
import processing.sound.* ;
SoundFile sound;
//déclaration d'une liste appelée "liste" d'éléments de la class Ball
ArrayList<Ball> liste= new ArrayList<>();
//déclaration de variables de type entier
int ballWidth = 30;
int locY=180, locX=500;
int larg1=30, larg2=30;
int locX2=140, locY2=180;
//déclaration d'une variable de type décimal
float souris1,souris2,compteur;
//déclaration de variables de type booléen
boolean overBall1=false;
boolean overBall2=false;
boolean locked1=false;
boolean locked2=false;
boolean disparu1=false;
boolean disparu2=false;

//déclarationde la fonction setup:
void setup() {
  //initialisation taille de fenêtre
  size(640, 360);
  //chargement de l'image sous le nom défini dans les fichiers
  img = loadImage("balle.png");
  sound = new SoundFile(this, dataPath("ball.wav"));
  
}

//ouverture de la fonction draw:
void draw() {
  background(255);
  //centrer les images
  imageMode(CENTER);
  //déclaration des images avec les coordonnées x,y puis la taille z,q
  image(img, locX, locY,larg1,larg1);
  image(img, locX2, locY2,larg2,larg2);
  /*calculs permettant de vérifier si la souris se trouve sur l'image
  si cette variable est négative on considère que nous sommes sur l'image*/
  souris1=sqrt(sq(mouseX-locX)+sq(mouseY-locY))-13;
  souris2=sqrt(sq(mouseX-locX2)+sq(mouseY-locY2))-13;
  //si on est sur l'image1 la varibale voulue passe sur vraie
  if (souris1<0){
    overBall1=true;
  }
  //si on est sur l'image2 la varibale voulue passe sur vraie
  if(souris2<0){
    overBall2=true;
  }
  //si la variable disparu1 ou 2 passe à vrai l'image disparait (largeur=0) 
  if(disparu1){
    larg1=0;
    //assure de ne pas pouvoir reposer une seconde balleen cliquant nul part
    locked1=false;
  }
  if (disparu2){
    larg2=0;
    locked2=false;
  }
  //si une balle est créé, la liste va être de taille 1 et va donc animer
  //la balle avec les fonction ball.move et display définis dans la class Ball
  //Pour sélectioner la bonne balle on utiliser liste.get(i) = bon élément dans la liste.
  for (int i = liste.size()-1; i>=0; i--) { 
    Ball ball = liste.get(i);
    ball.move();
    ball.display();
  }
}

//ouverture de la fonction mousePressed() (quand on appuie sur la souris):
void mousePressed() {
  //quand on est sur la balle la variable est à vraie
  if(overBall1){
    /*débloque d'autres conditions quand la souris est pressée (des id dans 
    d'autres fonction plus basses dans le programme)*/
    locked1 = true;
    //repasse à faux pour ne pas pouvoir recliquer sur ses coordonnées
    overBall1=false;
  }else{
    //sécurité qui n'a pas forcément de rôle
    locked1=false;
  }
  if(overBall2){
    locked2 = true;
    overBall2=false;
  }else{
    locked2=false;
  }
}


//ouverture de la fonction de mouvement de la souris:
void mouseDragged(){
  //si la balle1 est bien sélectionnée avec la souris
  if (locked1){
    //on prend en coordonnées la souris qui bouge
    locX=mouseX;
    locY=mouseY;
    /*Les 4 prochains if permettent de ne pas faire sortir la balle
    de la fenêtre afin de toujours l'avoir en vision*/
    if(locX<0){
      locX=0;
    }
    if(locX>width){
      locX=width;
    }
    if(locY<0){
      locY=0;
    }
    //le -14 permet de ne pas aller au plus bas de la page et que 
    //l'effet ne soit pas "irréel" dans le pied de page.
    if(locY>height-14){
      locY=height-14;
    }
  }
  if (locked2){
    locX2=mouseX;
    locY2=mouseY;
    if(locX2<0){
      locX2=0;
    }
    if(locX2>width){
      locX2=width;
    }
    if(locY2<0){
      locY2=0;
    }
    if(locY2>height-14){
      locY2=height-14;
    }
  }
}

//déclaration de la fonction de relachement de la souris
void mouseReleased(){
  //si on a la balle en sélection (l'une ou l'autre=else if)
  if(locked1){
    //la variable qui active la disparition plus haut
    disparu1=true;
    /*on ajoute une nouvelle balle en utilisant le constructeur de la classe
    avec les paramètres que l'on veut et que l'on pourra réutiliser
    dans notre cas la balle part de la position à laquelle on lache la balle
    ainsi que sa taille de la balle.*/
    liste.add(new Ball(locX, locY, ballWidth));
  }else if (locked2){
    disparu2=true;
    liste.add(new Ball(locX2, locY2, ballWidth));
  }
}
