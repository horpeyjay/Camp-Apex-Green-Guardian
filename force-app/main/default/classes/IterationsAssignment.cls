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

    public static Integer euclideanAlgo(Integer num1, Integer num2){
        /**
         * Write a class in Apex with a method, pass two numbers as the parameter to the
            same method, and print the GCD (Greatest Common Divisor) of the two. GCD of two integers
            is calculated by the continued division method. Divide the larger number by the smaller
            number; the remainder then divides the previous divisor. The process is repeated till the
            remainder is 0. The divisor then results in the GCD
        */
        Integer min = Math.min(num1, num2);
        Integer max = Math.max(num1, num2);
        Integer leftOver;
        do{
            leftOver = Math.mod(max, min);
            max = min;
            if(leftOver == 0){
                break;
            }
            min = leftOver;
        }while(leftOver > 0);
        System.debug(min);
        return min; 
    }
}