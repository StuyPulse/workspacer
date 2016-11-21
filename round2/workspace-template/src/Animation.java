import gui.GuiSimple;

// Animation: Our first class!
// The comments are a bit excessive, but hopefully they get the ideas across.
public class Animation extends GuiSimple {

    // Initialize Variables
    private double xPos;
    private double yPos;
    private double xVelocity;
    private double yVelocity;

    // This runs when an Animation is created
    public Animation() {
        xPos = 200.0;
        yPos = 0.0;
        xVelocity = 1.0;
        yVelocity = 0.0;
    }

    // draw(). Is called once every frame
    public void draw() {
        // clear the screen so that we don't redraw to the same frame
        screen.clear();

        // screen.circle( x , y , radius )
        screen.circle(xPos, yPos, 10);

        // "Bounce" when we reach the bottom of the screen
        if (yPos > 400) {
            yPos = 400
            yVelocity *= -1;
        }

        // Bounce when we reach the sides of the screen
        if (xPos > 400) {
            xPos = 400;
            xVelocity *= -1;
        } else if (xPos < 0) {
            xPos = 0;
            xVelocity *= -1
        }

        // simulate gravity
        yVelocity += 0.5;

        xPos += xVelocity;
        yPos += yVelocity;
    }

    // main(). You'll learn what this means later
    public static void main(String[] args) {
        begin(new Animation());
    }
}

