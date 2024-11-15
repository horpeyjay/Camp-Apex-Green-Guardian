public with sharing class IterationsAssignment {
    public static List<Integer> fibonacci (Integer num){
        /**
         * - Write a class in Apex with a method, pass a number as a parameter to the same
            method, and print that many terms of the Fibonacci numbers. The first two Fibonacci numbers
            are 0 and 1, and each subsequent number is the sum of the previous two.
            For example, 0, 1, 1, 2, 3, 5, …

        */
        List<Integer> fib = new List<Integer>();
        fib.add(0);
        fib.add(1);
        for(Integer i = 2; i < num; i++){
            Integer a = fib.get(i-1) + fib.get(i-2);
            fib.add(a);
        }
        System.debug(fib);
        return fib;
    }
}