import gui.GuiSimple;

public class Animation extends GuiSimple {
    private double yPos;

    // This runs when an Animation is created
    public Animation() {
        yPos = 0.0;
    }

    public void draw() {
        screen.clear();
        screen.circle(200.0, yPos, 10);

        yPos += 1.0;
    }

    public static void main(String[] args) {
        begin(new Animation());
    }
}

