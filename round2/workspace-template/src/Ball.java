import gui.Screen;







public class Ball {

    public double posX;
    public double posY;
    public double velX;
    public double velY;

    public Ball(double vx, double vy) {
        posX = 200.0;
        posY = 0.0;
        
        velX = vx;
        velY = vy;
    }

    public void render(Screen serena) {
        serena.circle(posX, posY, 10.0);
    }

    public void update() {
        // "Bounce" when we reach the bottom of the screen
        if (posY > 400) {
            posY = 400;
            velY *= -1;
        }

        // Bounce when we reach the sides of the screen
        if (posX > 400) {
            posX = 400;
            velX *= -1;
        } else if (posX < 0) {
            posX = 0;
            velX *= -1;
        }

        // simulate gravity
        velY += 0.5;

        posX += velX;
        posY += velY;
    }

}

