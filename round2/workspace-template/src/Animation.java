import gui.GuiSimple;

// Animation: Our first class!
// The comments are a bit excessive, but hopefully they get the ideas across.
public class Animation extends GuiSimple {
    // Create two variables, xPos and yPos which hold numbers with decimal points.
    // These variables start off empty but can be given values.
    private double xPos;
    private double yPos;

    // This runs when an Animation is created
    public Animation() {
        // Put values into xPos and yPos so that they are not empty and can be used to draw a circle
        xPos = 200.0;
        yPos = 0.0;
    }

    // draw(). Is called once every frame (60 frames a second)
    public void draw() {
        // clear the screen so that we don't redraw to the same frame
        // (if we don't do this the drawings won't go away and the circle will create a thick line)
        screen.clear();

        // screen.circle(x,y,radius). This function draws a circle at coordinates xPos,yPos in pixels of radius 10 pixels.
        screen.circle(xPos, yPos, 10);

        // update xPos and yPos by increasing them by 1 every frame.
        // This makes the ball move down and to the right.
        xPos += 1.0;
        yPos += 1.0;
    }

    // main(). You'll learn what this means later
    public static void main(String[] args) {
        begin(new Animation());
    }
}

