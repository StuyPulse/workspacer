import gui.GuiSimple;

public class Animation extends GuiSimple {
    private double yPos;
    private double velocity;

    public void setup() {
        yPos = 0.0;
        velocity = 0.0;
    }

    public void draw() {
        screen.clear();
        screen.circle(200.0, yPos, 10);

        yPos += velocity;
        velocity += 1.0;
    }

    public static void main(String[] args) {
        begin(new Animation());
    }
}

