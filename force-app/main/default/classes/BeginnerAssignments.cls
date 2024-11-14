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
}