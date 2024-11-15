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

    public static void autoMorphic(Integer num){
        /**
         * Write a class in Apex with a method, pass a number as the parameter to the same
            method, and check if it is an Automorphic Number or not. An automorphic number is a number
            that is contained in the last digit(s) of its square. For example, 25 is an automorphic number as
            its square is 625, and 25 is present as the last two digits.

        */
        Integer squareNumbers = num * num;
        String square = String.valueOf(squareNumbers);
        String numWord = String.valueOf(num);
        String lastDigit = square.right(2);
        if(numWord == lastDigit){
            System.debug('It is an automorphic number');
        }else{
            System.debug('It is not an automorphic number');
        
        }
    }

    public static Boolean primeNumber(integer num){
        for(Integer i = 2; i < num; i++){
            if(Math.mod(num, i) == 0){ 
                return false;
                
            }
        }
        return true;
    }
    public static void primeemirp(Integer primeNumber){
        /**
         * Write a class in Apex with a method, pass a number as the parameter to the same
            method, and print whether the number is an EMIRP number or not. A number is said to be
            EMIRP if the number, and it’s reverse both are prime numbers. For example, 13, 17, etc
        */
        
        
        String numWord = String.valueOf(primeNumber);
        numWord = numWord.reverse();
        Integer emirp = Integer.valueOf(numWord);
        Boolean isPrime = primeNumber(primeNumber);
        Boolean isEmirp = primeNumber(emirp);
        if(isPrime == true && isEmirp == true){
            System.debug('The number is an EMIRP number');
        }else{
            System.debug('The number is not an EMIRP number');
        }
    }

    public static void deduncyNumber (Integer num){
        /**
         * Write a class in Apex with a method, pass a number as the parameter to the same
method, and print whether the number is a Dudeney number. A Dudeney number is a positive
integer that is a perfect cube such that the sum of its digits is equal to the cube root of the
number.
For example, 512 is a Dudeney number.
5 + 1 + 2 = 8
Cube root of 512 = 8
        */
        Decimal sum = 0;
        String numWords = String.valueOf(num);
        for(Integer i = 0; i < numWords.length(); i++){
            String currentWord = numWords.substring(i, i + 1);
            Decimal currentNumber = (Decimal) Integer.valueOf(currentWord);
            sum += currentNumber;
        }

        Decimal cubeRoot = Math.cbrt(num);
        if(cubeRoot == sum){
            System.debug('The number is a Dudeney number');
        }else{
            System.debug('The number is not a Dudeney number');
        }
    }
}