public class BankAccount {
    private double balance;
    private String firstName;
    private String lastName;

    public BankAccount(String first, String last) {
        balance = 0;
        firstName = first;
        lastName = last;
    }

    public void deposit(double amount) {
        balance += amount;
    }

    public static void main(String[] args) {
        BankAccount myBank = new BankAccount("Bruce", "Wayne");
        System.out.println(myBank.balance);
        System.out.println(myBank.firstName + " " + myBank.lastName);
        
        myBank.deposit(1000.0);
        
        System.out.println(myBank.balance);
    }
}

