// Started in Lesson 7 (Dec 1)
public class Stats {
    public static void main(String[] args) {
        int[] values = new int[5];
        values[0] = 7;
        values[1] = 3;
        values[2] = 4;
        values[3] = -2;
        values[4] = 12;
        printArray(values);

        int smallest = minimum(values);
    }

    public static int minimum(int[] dataset) {
        // ... we'll get to this ...
        return 0;
    }

    public static double triple(double input) {
        return input * 3;
    }

    public static void printArray(int[] fred) {
        for (int i = 0; i < fred.length; i += 1) {
            System.out.println(fred[i]);
        }
    }
}
