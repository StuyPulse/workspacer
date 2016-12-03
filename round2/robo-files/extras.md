# Interactivity

This is a guide to adding interactivity to the stuff you guys are
working on.

__Doing this stuff will not put you fundamentally ahead of the class, and
*not* doing this stuff will *not* make you behind. This allows people who
are already comfortable with some of the material to have fun with
it.__ If that's not you, don't worry about it.

That said, go to town with this stuff.

First of all, to run code from another file, copy the contents of
`Animation.java` to `MyThing.java` and find-and-replace "Animation" with
"MyThing" in the file. Then, to run `MyThing.java`, just do:

    $ make class=MyThing

---
### Mouse input

Just like we can draw to the screen with the `screen` object, we can
interact with the mouse with the `mouse` object.

The mouse object has four "methods" (we'll discuss methods soon as a
group). They're used as follows:

    mouse.getX() // a number: the x position of the mouse
    mouse.getY() // a number: the y position of the mouse
    mouse.clicked() // a condition. Did the mouse click?
    mouse.isPressed() // a condition. Is the mouse currently pressed?

Example: if the mouse clicked, draw a circle at the cursor:

    if (mouse.clicked()) {
        screen.circle(mouse.getX(), mouse.getY(), 10);
    }

---
### Keyboard input

For this, you'll be using "stuff" that we haven't been using so far,
and you have to import it. At the top of the file, add:

    import javafx.scene.input.KeyCode;

`KeyCode.A` to refers to the 'A' key; `KeyCode.F` to the 'F' key;
`KeyCode.SPACE` to the spacebar; etc.

Similar to using the mouse, the `keyboard` object gives you access to
the keyboard, and has the method `isKeyPressed`.

Example usage:

    if (keyboard.isKeyPressed(KeyCode.A)) {
        xPos -= 3.0;
    }

This will decrease `xPos` when the user is pressing 'A'.

---
### Stylized drawing

##### Shapes

    screen.circle(<x>, <y>, <radius>)
    screen.ellipse(<x>, <y>, <width>, <height>);
    screen.rect(<x>, <y>, <width>, <height>); // rectangle

You can also bring some images in, on a flash drive or something, and render them:

    screen.image("path/to/image.png", <x>, <y>);
    screen.image("path/to/image.png", <x>, <y>, <width>, <height>);

##### Color

Import:

    import javafx.scene.paint.Color;

This exposes you to you many colors, like `Color.GREEN`, `Color.RED`, and
`Color.SKYBLUE`. You can also write `Color.rgb(<red>, <green>, <blue>)` to
use any RGB color you want (each number is on a scale from 0 to 255).

To use a color, call the `setColor` method of `screen`:

    screen.setColor(Color.SKYBLUE);

All the things you draw after this, until calling `setColor` again,
will be sky blue.
