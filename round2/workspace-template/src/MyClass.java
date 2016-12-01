import java.util.Scanner;

public class MyClass {
    public static int factorial(int n) {
        int count = 1;
        int result = 1;
        while (count <= n) {
            result *= count;
            System.out.println("current result: " + result);
            count += 1;
        }
        return result;
    }


    public static void main(String[] args) {
        Scanner s = new Scanner(System.in);

        int input = s.nextInt();
    
        int fact = factorial(input);
        System.out.println(fact);
    }
}
