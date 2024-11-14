public with sharing class BeginnerAssignments {
    /**
     * Exercise 1- Write a class in Apex to create three variables for Principal Amount, Rate of
        Interest, and Time Duration and show the Simple Interest and Total Amount using debug
        statement.

     */
    public static void simpleInterestCalculator(Integer principal, Decimal rate, Integer duration) {
        Decimal simpleInterest = (principal * rate * duration) / 100;
        simpleInterest = simpleInterest.setScale(2);
        Decimal totalAmountWithInterest = principal + simpleInterest;
        totalAmountWithInterest = totalAmountWithInterest.setScale(2);
        system.debug('The simple interest is => ' + simpleInterest);
        system.debug('The total amount with interest is => ' + totalAmountWithInterest);
    }

    /**Write a class in Apex to create a Date variable with today’s date and print the date
    after 100 days from today. */
    public static void days100FromToday(){
        Date finalDate = Date.today() + 100;
        System.debug('Added 100 days to today\'s date =>' + finalDate);
    }

    /**
     * Write a class in Apex and print the following message using only one debug
        statement.
        “Worldwide Corporate Headquarters”
        Salesforce, Inc., ‘Salesforce Tower’,
        415 Mission Street, 3rd Floor
        San Francisco, CA 94105

     */
    public static void complexString(){
        String companyAddress = '\n\t\"Worldwide Corporate Headquarter\" \n\t Salesforce, Inc., \'Salesforce Tower\', \n\t 415 Mission Street, 3rd Floor \n\t San Francisco, CA 94105';
        System.debug('The company address is =>' + companyAddress);
    }

    /**
     * Write a class in Apex and accept the radius of a circle as the method parameter of
the method in a class and calculate the circumference and area of a circle.
[Hint:
1. The formula for the calculation
Area of circle = PI * (R)2
Circumference of Circle = 2 * PI * R
2. Use 3.14 as the value of PI.
3. Use constant to store the value of PI.

     */

    public static List<Decimal> calculateAreaOfCircle (Integer radius){
        final Decimal PI = 3.14;
        Decimal area = PI * (radius * radius);
        area = area.setScale(2);
        Decimal circumference = 2 * PI * radius;
        circumference = circumference.setScale(2);
        List<Decimal> returnValues = new List<Decimal>{area, circumference};
        return returnValues;
    }

    /**
     * Write a class in Apex with an Enum for holding months of a year. Create a
method in the same class that accepts the Enum type as a parameter and print the month
passed. Create different variables of this Enum and pass them to this method.

     */
    public enum Months {JAN, FEB, MAR, APR, MAY, JUN, JUL, AUG, SEP, OCT, NOV, DEC}


    public static void enumMethod() {
        // Assigning each month and debugging it
        Months One = Months.JAN;
        System.debug('Month One: ' + One);
        
        Months Two = Months.FEB;
        System.debug('Month Two: ' + Two);
        
        Months Three = Months.MAR;
        System.debug('Month Three: ' + Three);
        
        Months Four = Months.APR;
        System.debug('Month Four: ' + Four);
        
        Months Five = Months.MAY;
        System.debug('Month Five: ' + Five);
        
        Months Six = Months.JUN;
        System.debug('Month Six: ' + Six);
        
        Months Seven = Months.JUL;
        System.debug('Month Seven: ' + Seven);
        
        Months Eight = Months.AUG;
        System.debug('Month Eight: ' + Eight);
        
        Months Nine = Months.SEP;
        System.debug('Month Nine: ' + Nine);
        
        Months Ten = Months.OCT;
        System.debug('Month Ten: ' + Ten);
        
        Months Eleven = Months.NOV;
        System.debug('Month Eleven: ' + Eleven);
        
        Months Twelve = Months.DEC;
        System.debug('Month Twelve: ' + Twelve);

        
    }

    public static void showMonths(Months monthInWords) {
        // Calls enumMethod to display all months
        enumMethod();
        
        // Display the specific month passed to showMonths
        System.debug('Selected Month: ' + monthInWords);
    }
}