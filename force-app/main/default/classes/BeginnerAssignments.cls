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
}