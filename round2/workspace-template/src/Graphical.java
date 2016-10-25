import gui.GuiSimple;

public class Graphical extends GuiSimple {
    public void setup() {
    }

    public void draw() {
        screen.clear();
        if (mouse.clicked()) {
            screen.circle(mouse.getX() - 10.0, mouse.getY() - 10.0, 15);
        } else {
            screen.circle(mouse.getX() - 10.0, mouse.getY() - 10.0, 10.0);
        }
    }

    public static void main(String[] args) {
        begin(new Graphical());
    }
}
