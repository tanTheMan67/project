import java.util.Scanner;
public class PasswordValidator {
    static String checkPassword(String password) {
        if (password.length()<8) {
            return "Too short.Password must be atleast 8 characters!";
        }
        boolean hasUpper=false;
        boolean hasLower=false;
        boolean hasDigit=false;
        boolean hasSpecial=false;
        String specialChars="!@#$%^&*";
        for (int i=0;i<password.length();i++){
            char c =password.charAt(i);
            if (Character.isUpperCase(c))hasUpper =true;
            if (Character.isLowerCase(c))hasLower =true;
            if (Character.isDigit(c))hasDigit=true;
            if (specialChars.indexOf(c)>=0)hasSpecial=true;
        }
        if(!hasUpper)return "Missing an uppercase letter.";
        if(!hasLower)return "Missing a lowercase letter.";
        if(!hasDigit)return "Missing a digit (0-9).";
        if(!hasSpecial)return "Missing a special character (!@#$%^&*).";
        return "valid";
    }
    static String getStrength(String password) {
        int score = 0;
        if (password.length() >= 8) score++;
        if (password.length() >= 12) score++;
        for (int i=0;i<password.length();i++) {
            char c=password.charAt(i);
            if(Character.isUpperCase(c)){
                 score++;
                  break;
                 }
        }
        for(int i=0;i<password.length();i++){
            char c=password.charAt(i);
            if (Character.isDigit(c)){
                 score++;
                 break;
                }
        }
        for (int i= 0;i<password.length();i++){
            char c=password.charAt(i);
            if("!@#$%^&*".indexOf(c)>=0){ 
                score++;
                 break;
                 }
        }

        if(score<=2)return "too Weak";
        if(score<=4)return "ok";
        return "Strong";
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int attempts = 0;

        System.out.println("Welcome to PassWRD,the only stop to ensure safe password!!");
        System.out.println("Our Free Plan offers 30 Tokens");
        System.out.println("PAY 10$ to unlock premium features");
        System.out.println("Encryptions such as SHA-2 available for more security");
        System.out.println();

        while(true){
            System.out.print("Enter password: ");
            String password = sc.nextLine().trim();
            attempts++;
            String result = checkPassword(password);
            if(result.equals("valid")) {
                String strength = getStrength(password);
                System.out.println("Congratulations...Password accepted!");
                System.out.println("Strength of your password is: " + strength);
                System.out.println("Attempts exhausted: " + attempts);
                break;
            } 
            else{
                System.out.println("Invalid,oops you wasted an attempt : " + result);
                System.out.println("Try again...");
            }
        }

        sc.close();
    }
}
