import gui.GuiSimple;

public class Falling extends GuiSimple {
    private double _ballHeight;
    private double _velocity;

    public void setup() {
        _ballHeight = 0.0;
        _velocity = 0.0;
    }

    public void draw() {
        screen.clear();
        screen.circle(200.0, _ballHeight, 10);

        _ballHeight += _velocity;
        _velocity += 1.0;
    }

    public static void main(String[] args) {
        begin(new Falling());
    }
}

