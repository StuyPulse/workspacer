// Started in Lesson 7 (Dec 1)
public class Stats {





    public static void main(String[] args) {
        double foo = 0.5;
        double bar = f(foo);
        foo = bar;
        foo = 5;
        int[] values = new int[5];
        values[0] = 7;
        values[1] = 3;
        values[2] = 4;
        values[3] = -2;
        values[4] = 12;
        int smallest = minimum(values);
        
        System.out.println(   f(13)  );
    }
    
    public static int minimum(int[] dataset) {
        int minSoFar = dataset[0];
        for (int i = 1; i < dataset.length; i++) {
            int element = dataset[i];
            if (element < minSoFar) {
                minSoFar = element;
            }
        }
        return minSoFar;
    }
    
    public static double f(double x) {
        return 2 * x;
    }

    public static void printArray(int[] fred) {
        for (int i = 0; i < fred.length; i += 1) {
            System.out.println(fred[i]);
        }
    }
}
