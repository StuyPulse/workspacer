import gui.GuiSimple;

// Animation: Our first class!
// The comments are a bit excessive, but hopefully they get the ideas across.
public class Animation extends GuiSimple {

    // Initialize Variables
    private double yPos;
    private double velocity;

    // This runs when an Animation is created
    public Animation() {
        yPos = 0.0;
        velocity = 0.0;
    }

    // draw(). Is called once every frame
    public void draw() {
        // clear the screen so that we don't redraw to the same frame
        screen.clear();

        // screen.circle( x , y , radius )
        screen.circle(200, yPos, 10);

        // "Bounce" when we reach the bottom of the screen
        if (yPos >= 400) {
            velocity *= -1;
        }
        // Increase velocity to simulate gravity and change yPos by velocity
        velocity += 0.5;
        yPos += velocity;
    }

    // main(). You'll learn what this means later
    public static void main(String[] args) {
        begin(new Animation());
    }
}

