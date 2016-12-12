import gui.GuiSimple;

public class Animation extends GuiSimple {

    public Ball wilson;
    public Ball spalding;

    // This runs when an Animation is created
    public Animation() {
        wilson = new Ball(2.718, 6.28);
        spalding = new Ball(3.33,3.43);
    }

    // draw(). Is called once every frame
    public void draw() {
        //jebron
        screen.clear();
        wilson.update();
        spalding.update();
        wilson.render(screen);
        spalding.render(screen);
    }

    // main(). You'll learn what this means later
    public static void main(String[] args) {
        double foo = 0.5;
        int[] values = new int[5];
        Animation balls = new Animation();
        while (true) {
            balls.draw();
        }
    }
}

