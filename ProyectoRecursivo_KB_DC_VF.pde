// Variables principales
int menu = 0;
boolean estado = false; 
boolean gano = false;

// Matriz
int[][] matriz; 
int M = 10;
int N = 10;
float t; // Tamaño x cuadro
float dx, dy;

// CONDICIONES
int tapcontador; 
boolean limiteAlcanzado = false; 
int tiempoLimite = 30; 
int tiempoRestante; 
int tiempoInicio;

int vidas = 3;

// BOTONES
int nivel = 1;
float Mx, Nx, MNy;
float tx1, tx2, ty;
int contador = 10; 
float nx, ny;
float h, sep;
float bx, by, btx, bty;
float vx, vy;

// IMAGENES
PImage fondo; 
PImage imagen;
PImage flor;
PImage flor2;
PImage victoria;
PImage derrota;

float prop_x;
float prop_y;

void setup() {
  fullScreen();
  fondo = loadImage("Recursivo.png");
  fondo.resize(width, height);
  flor = loadImage("loto1.png");
  flor2 = loadImage("loto3.png");
  victoria = loadImage("gano.png");
  derrota = loadImage("perdio.png");
  
  prop_x = width / 2160.0;
  prop_y = height / 1440.0;
  
  t = 50 * min(prop_x, prop_y);
  dx = width * 0.3;
  dy = height * 0.1;
  
  Mx = 775 * prop_x;
  Nx = 1100 * prop_x;
  MNy = 1085 * prop_y;
  
  tx1 = 1258 * prop_x;
  tx2 = 793 * prop_x;
  ty = 963 * prop_y;
  
  nx = 755 * prop_x;
  ny = 400 * prop_y;
  h = 95 * prop_y;
  sep = 100 * prop_y;
  
  bx = 833 * prop_x;
  by = 1228 * prop_y;
  btx = 495 * prop_x;
  bty = 130 * prop_y;
  
  vx = 105 * prop_x;
  vy = 25 * prop_y;
}

void draw() {
  switch (menu) {
    case 0:
      principal();
      break;
    case 1:
      level1();
      if (gano) {
        image(victoria, 0, 0, width, height);
      }
      if (vidas == 0 || tiempoRestante == 0 || tapcontador == 0) {
        image(derrota, 0, 0, width, height);
      }
      break;
    case 2:
      level2();
      if (gano) {
        image(victoria, 0, 0, width, height);
      }
      if (vidas == 0 || tiempoRestante == 0 || tapcontador == 0) {
        image(derrota, 0, 0, width, height);
      }
      break;
    case 3:
      level3();
      if (gano) {
        image(victoria, 0, 0, width, height);
      }
      if (vidas == 0 || tiempoRestante == 0 || tapcontador == 0) {
        image(derrota, 0, 0, width, height);
      }
      break;
    default:
      principal();
  }
}

void principal() {
  image(fondo, 0, 0, width, height);
  fill(0);
  textSize(48);
  textAlign(LEFT, UP);
  text(str(contador), 1045 * prop_x, 985 * prop_y, 190, 78);
}

void level1() {
  imagen = loadImage("Nivel_1.png");
  image(imagen, 0, 0, width, height);
  if (estado) {
    mostrarMatrizRecursivo(0, 0, dx, dy);
    verificarTiempo();
    mostrarInfo();
  }
}

void level2() {
  imagen = loadImage("Nivel_2.png");
  image(imagen, 0, 0, width, height);
  if (estado) {
    mostrarMatrizRecursivo(0, 0, dx, dy);
    verificarTiempo();
    mostrarInfo();
  }
}

void level3() {
  imagen = loadImage("Nivel_3.png");
  image(imagen, 0, 0, width, height);
  if (estado) {
    mostrarMatrizRecursivo(0, 0, dx, dy);
    verificarTiempo();
    mostrarInfo();
  } 
}

void mousePressed() {
  switch (menu) {
    case 0:
      if ((mouseX > bx && mouseX < (bx + btx)) &&
          (mouseY > by && mouseY < (by + bty))) {
        menu = nivel;
        int f = 2;
        if (nivel == 3) {
          f = 3;
        } 
        iniciarJuego(f);
        println("Iniciando programa...");
      }
      if ((mouseX > tx1 && mouseX < (tx1 + 110 * prop_x)) &&
          (mouseY > ty && mouseY < (ty + 100 * prop_y)) && contador < 20) {
        contador++;
        println("Contador: " + contador);
      }
      if ((mouseX > tx2 && mouseX < (tx2 + 110 * prop_x)) &&
          (mouseY > ty && mouseY < (ty + 100 * prop_y)) && contador > 10) {
        contador--;
        println("Contador: " + contador);
      }
      if ((mouseX > Mx && mouseX < (Mx + 280 * prop_x)) &&
          (mouseY > MNy && mouseY < (MNy + 80 * prop_y))) {
        M = contador;
        println("M: " + M);
      }
      if ((mouseX > Nx && mouseX < (Nx + 280 * prop_x)) &&
          (mouseY > MNy && mouseY < (MNy + 80 * prop_y))) {
        N = contador;
        println("N: " + N);
      }
      for (int i = 0; i < 3; i++) {
        if (mouseX > nx && mouseX < (nx + 650 * prop_x) &&
            mouseY > (ny + i * sep) && mouseY < (ny + i * sep + h)) {
          nivel = i + 1;
          println("Nivel " + nivel + "...");
          break;
        }
      }
      break;
    case 1:
    case 2:
    case 3:
      if ((mouseX > vx && mouseX < (vx + 300 * prop_x)) &&
          (mouseY > vy && mouseY < (vy + 100 * prop_y))) {
        menu = 0;
        println("Regresando al menú principal...");
      }
      if (estado){
        int x = int((mouseX - dx) / t);
        int y = int((mouseY - dy) / t);

        if (x >= 0 && x < M && y >= 0 && y < N && matriz[x][y] > 0) {
          int valorInicial = matriz[x][y];
          explotarBurbujaRecursivo(x, y, valorInicial);
          tapcontador--;
          gano=verificarVictoriaRecursivo(0,0); 
        } else {
          if (gano || vidas <= 0) {
            estado = false;
            vx= 85 * prop_x;
            vy= 85 * prop_y;
            if ((mouseX > vx && mouseX < (vx + 420 * prop_x)) &&
              (mouseY > vy && mouseY < (vy + 115 * prop_y))) {
              menu = 0;
              println("Regresando al menú principal...");
            }
          } else {
            vidas--;
          }      
        }
      }
      break;
  }
}

void inicializarMatrizRecursivo(int i, int j, int f) {
    if (i >= M) {
        return;
    }
    if (j >= N) { 
        inicializarMatrizRecursivo(i + 1, 0, f); //avanzar fila
        return;
    }
    matriz[i][j] = (int)random(f); //valor aleatorio 
    inicializarMatrizRecursivo(i, j + 1, f); //avanzar columna
}

void iniciarJuego(int f) {
  matriz = new int[M][N];
  
  inicializarMatrizRecursivo(0, 0, f);
  
  if(nivel==1 || nivel ==3){
    tapcontador = (N < 15 && M < 15) ? 20 : 25;
  } else if(nivel==2){
    tapcontador = (N < 15 && M < 15) ? 15 : 20;
  } 
  
  tiempoRestante = tiempoLimite;
  tiempoInicio = millis();
  vidas = 3;
  gano = false;
  estado = true;
}

void mostrarMatrizRecursivo(int i, int j, float dx, float dy) {
  if (i >= M) return;

  float x = dx + (i * t);
  float y = dy + (j * t);

  if (matriz[i][j] == 1) {
    fill(90, 166, 15);
    rect(x, y, t, t);
    float florSize = t * 0.9;
    image(flor, x + (t - florSize) / 2, y + (t - florSize) / 2, florSize, florSize);
  } else if (matriz[i][j] == 2) {
    fill(90, 166, 15);
    rect(x, y, t, t);
    float florSize = t * 0.9;
    image(flor2, x + (t - florSize) / 2, y + (t - florSize) / 2, florSize, florSize);
  } else {
    fill(225, 240, 201);
    rect(x, y, t, t);
  }
  if (j < N - 1) {
    mostrarMatrizRecursivo(i, j + 1, dx, dy);
  } else {
    mostrarMatrizRecursivo(i + 1, 0, dx, dy);
  }
}

void mostrarInfo() {
  fill(255);
  textSize(45);
  textAlign(RIGHT);
  text(tiempoRestante, 2050 * prop_x, 100 * prop_y);
  textAlign(LEFT);
  text("Vidas: " + vidas, 650 * prop_x, 100 * prop_y);
  textAlign(CENTER);
  text(tapcontador, 1695*prop_x, 100 * prop_y);
}

void verificarTiempo() {
  tiempoRestante = tiempoLimite - (millis() - tiempoInicio) / 1000;
  if (tiempoRestante <= 0) {
    estado = false;
    tiempoRestante = 0;
  }
}

void explotarBurbujaRecursivo(int x, int y, int valorInicial) {
  if (x < 0 || x >= M || y < 0 || y >= N || matriz[x][y] != valorInicial) return;
  matriz[x][y]--;
  explotarBurbujaRecursivo(x, y - 1, valorInicial); // Izquierda
  explotarBurbujaRecursivo(x, y + 1, valorInicial); // Derecha
  explotarBurbujaRecursivo(x + 1, y, valorInicial); // Abajo
  explotarBurbujaRecursivo(x - 1, y, valorInicial); // Arriba
}

boolean verificarVictoriaRecursivo(int i, int j) { //comienza en (0,0)
    if (i >= M) {
        return true; 
    }
    if (j >= N) {
        return verificarVictoriaRecursivo(i + 1, 0); // avanzar fila
    }
    if (matriz[i][j] > 0) {
        return false; // Se encontró una flor, entonces no ha ganado
    }
    return verificarVictoriaRecursivo(i, j + 1); //avanzar columna
}
