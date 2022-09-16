//ouverture de la class Ball
class Ball {
  //déclration des varibales globales à la classe
  float x;
  float y;
  float speed;
  float gravity;
  float sizeBall;
  boolean test=true;
  
  //ouverture du constructeur avec le même nom que la class
  //qui récupère les arguments rentrés dans le programme
  Ball(float _X, float _Y, float _W) {
    //on récupère les variables dans des variables de la class déclaré plus haut
    x = _X;
    y = _Y;
    sizeBall = _W;
    //vitesse de la balle
    speed = 0;
    //déclaration de la gravité
    gravity = 0.1;
  }
    //ouverture de la fonction mouve()
  void move() {
    //calcule permettant d'augemnter la variable de la "vitesse"
    speed = speed + gravity;
    //on ajoute à la position la varibale "vitesse" qui fait avancer la balle
    y = y + speed;
    //mettre le son en avance que la balle touche le sol afin d'éviter des problèmes de délais
    //il y a une valeur max afin d'éviter que le son sature à la fin
    if(y<345 && y>185 && speed==abs(speed) && test){
      sound.play() ;
      //variable qui empêche de rejouer le son en remontant
      test=false;
    }
    //si on arrive au bas de page (-14 pour éviter que la balle soit coupée)
    if (y > height-14) {
      //la vitesse va en sens inverse pour remonter
      speed = speed * -0.70;
      //la hauteur est donc celle du bas de la page puis va remonter etc...
      y = height-14;
      test=true;
    }
  }
  //ouverture de la fonction display qui s'occupe de l'affichage de l'image avec 
  //les paramètres voulus en position et taille.
  void display() {
    image(img, x, y,sizeBall,sizeBall);
  }
} 
