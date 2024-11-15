public with sharing class Assignment2 {
    public static void echoName(string name){
        String personName = name?.capitalize();
        system.debug('Hello ' + personName);
    }

    public List<Decimal> differentCalculations(Integer a, Integer b, Integer c, Integer d ){
        /**
         * Write a class in Apex with a method having 4 Integer parameters a, b, c, and d,
        perform the following mathematical operations, and show the output.

         */

        Decimal num1 = a + (b * c) / d;
        num1 = num1.setScale(3);
        Decimal num2 = (a + b) * (c+d)/(a+d);
        num2 = num2.setScale(3);
        Decimal num3 = (a*a)+(b*b)+(c*c)/(d*d*d);
        num3 = num3.setScale(3);

        List<Decimal> returnValues = new List<Decimal>{num1, num2, num3};
        system.debug(returnValues);
        return returnValues;
    }

    public Boolean validTriangle(Double a, Double b, Double c){
        Boolean isValid = (a+b)> c && (a+c)>b && (b+c)>a ? true : false;
        String valid = isValid ? 'Valid' : 'Invalid';
        system.debug(valid + 'Triangle');
        return isValid;
    }

    public static void multiplicationWithoutLoop(Integer num){
        
        Integer num1 = 1;
        Integer num2 = 2;
        Integer num3 = 3;
        Integer num4 = 4;
        Integer num5 = 5;
        num *= num1;
        system.debug(num);
        num *=num1;
        system.debug(num);
        num *=num2;
        system.debug(num);
        num *= num3;
        system.debug(num);
        num *= num4;
        system.debug(num);
        num *= num5;
        system.debug(num);
    }

    public static void stringModification(String str){
        /**
         * Write a class in Apex with a method and accept a String as a parameter of that
        method and display-
        (a) The String Value
        (b) Length of the String
        (c) String in Lowercase
        (d) String in Uppercase

         */
        String strValue = (str != null)? str : null;
        system.debug('string value => ' + strValue);
        Integer strlenght = str?.length();
        system.debug('string lenght => ' + strlenght);
        String strLower = str?.toLowerCase();
        system.debug('string to lower case => ' + strLower);
        String strUpper = str?.toUpperCase();
        system.debug('string to upper case => ' + strUpper);
    }

    public static void DeclareList(List<String> strList){
        if(!strList.isEmpty()){
            for(String s : strList){
                Integer index = strList.indexOf(s);
                system.debug('Element ' +s + 'Is in the list at the index of ' + index);
            }
        }
    }

    public static void getList(List<String> studentList){
        Boolean isEmptyList = studentList.isEmpty()? true : false;
        Integer size = studentList.size();
        system.debug(isEmptyList);
        system.debug('size of the list => ' + size);
    }

    public static void findEmployee(Set<String> empNames, Set<String> manager, Set<String> inCharge){
    
        List<String> inChargeList  = new List<String>();
        List<String> notInchargeList = new List<String>();
        List<String> causual = new List<String>();
        if(empNames != null){
            for(string emp : empNames){
                if(!manager.contains(emp)){
                    causual.add(emp);
                }
            }
            for(String man : manager){
                if(!empNames.contains(man)){
                    causual.add(man);
                }else{
                    if(manager.contains(man) && inCharge.contains(man)){
                        inChargeList.add(man);
                    }else{
                        notInchargeList.add(man);
                    }
                }
            }
        
        }

        system.debug('Employees not managers are ' + causual);
        system.debug('Employees who are managers and are incharge ' + inChargeList);
        system.debug('Employees who are not managers and are not incharge ' + notInchargeList);
    }

    public static string getColorCode(String colorName){
        Map<String, String> colorMap = new Map<String, String>{
            'red' => '#FF0000',
            'white' => '#FFFFFF',
            'cyan' => '#00FFFF',
            'silver' => '#C0C0C0',
            'blue' => '#0000FF',
            'gray' => '#808080',
            'grey' => '#808080',
            'darkblue' => '#00008B',
            'black' => '#000000',
            'lightblue' => '#ADD8E6',
            'orange' => '#FFA500',
            'purple' => '#800080',
            'brown' => '#A52A2A',
            'yellow' => '#FFFF00',
            'maroon' => '#800000',
            'lime' => '#00FF00',
            'green' => '#008000',
            'magenta' => '#FF00FF',
            'olive' => '#808000',
            'pink' => '#FFC0CB'
        };
        String colourName = colorname?.toLowerCase();
        String colorCode;
        if(colorMap.containsKey(colourName)){
            colorCode = colorMap.get(colorName);
        }
        return colorCode;
    }

    public static String capitalName(String countryName){
        Map<String, String> countryCapitalMap = new Map<String, String>{
            'Afghanistan' => 'Kabul',
            'Albania' => 'Tirana',
            'Algeria' => 'Algiers',
            'Andorra' => 'Andorra la Vella',
            'Angola' => 'Luanda',
            'Antigua and Barbuda' => 'St. John\'s',
            'Argentina' => 'Buenos Aires',
            'Armenia' => 'Yerevan',
            'Australia' => 'Canberra',
            'Austria' => 'Vienna',
            'Azerbaijan' => 'Baku',
            'Bahamas' => 'Nassau',
            'Bahrain' => 'Manama',
            'Bangladesh' => 'Dhaka',
            'Barbados' => 'Bridgetown',
            'Belarus' => 'Minsk',
            'Belgium' => 'Brussels',
            'Belize' => 'Belmopan',
            'Benin' => 'Porto Novo',
            'Bhutan' => 'Thimphu',
            'Bolivia' => 'Sucre',
            'Bosnia and Herzegovina' => 'Sarajevo',
            'Botswana' => 'Gaborone',
            'Brazil' => 'Brasilia',
            'Brunei' => 'Bandar Seri Begawan',
            'Bulgaria' => 'Sofia',
            'Burkina Faso' => 'Ouagadougou',
            'Burundi' => 'Bujumbura',
            'Cambodia' => 'Phnom Penh',
            'Cameroon' => 'Yaoundé',
            'Canada' => 'Ottawa',
            'Cape Verde' => 'Praia',
            'Central African Republic' => 'Bangui',
            'Chad' => 'N\'Djamena',
            'Chile' => 'Santiago',
            'China' => 'Beijing',
            'Colombia' => 'Bogota',
            'Comoros' => 'Moroni',
            'Costa Rica' => 'San José',
            'Croatia' => 'Zagreb',
            'Cuba' => 'Havana',
            'Cyprus' => 'Nicosia',
            'Czech Republic' => 'Prague',
            'Democratic Republic of Congo' => 'Kinshasa',
            'Denmark' => 'Copenhagen',
            'Djibouti' => 'Djibouti',
            'Dominica' => 'Roseau',
            'Dominican Republic' => 'Santo Domingo',
            'East Timor' => 'Dili',
            'Ecuador' => 'Quito',
            'Egypt' => 'Cairo',
            'El Salvador' => 'San Salvador',
            'Equatorial Guinea' => 'Malabo',
            'Eritrea' => 'Asmara',
            'Estonia' => 'Tallinn',
            'Eswatini' => 'Mbabane',
            'Ethiopia' => 'Addis Ababa',
            'Fiji' => 'Suva',
            'Finland' => 'Helsinki',
            'France' => 'Paris',
            'Gabon' => 'Libreville',
            'Gambia' => 'Banjul',
            'Georgia' => 'Tbilisi',
            'Germany' => 'Berlin',
            'Ghana' => 'Accra',
            'Greece' => 'Athens',
            'Grenada' => 'St. George\'s',
            'Guatemala' => 'Guatemala City',
            'Guinea' => 'Conakry',
            'Guinea-Bissau' => 'Bissau',
            'Guyana' => 'Georgetown',
            'Haiti' => 'Port-au-Prince',
            'Honduras' => 'Tegucigalpa',
            'Hungary' => 'Budapest',
            'Iceland' => 'Reykjavík',
            'India' => 'New Delhi',
            'Indonesia' => 'Jakarta',
            'Iran' => 'Tehran',
            'Iraq' => 'Baghdad',
            'Ireland' => 'Dublin',
            'Israel' => 'Jerusalem',
            'Italy' => 'Rome',
            'Ivory Coast' => 'Yamoussoukro',
            'Jamaica' => 'Kingston',
            'Japan' => 'Tokyo',
            'Jordan' => 'Amman',
            'Kazakhstan' => 'Astana',
            'Kenya' => 'Nairobi',
            'Kiribati' => 'Tarawa',
            'Korea, North' => 'Pyongyang',
            'Korea, South' => 'Seoul',
            'Kosovo' => 'Pristina',
            'Kuwait' => 'Kuwait City',
            'Kyrgyzstan' => 'Bishkek',
            'Laos' => 'Vientiane',
            'Latvia' => 'Riga',
            'Lebanon' => 'Beirut',
            'Lesotho' => 'Maseru',
            'Liberia' => 'Monrovia',
            'Libya' => 'Tripoli',
            'Liechtenstein' => 'Vaduz',
            'Lithuania' => 'Vilnius',
            'Luxembourg' => 'Luxembourg',
            'Madagascar' => 'Antananarivo',
            'Malawi' => 'Lilongwe',
            'Malaysia' => 'Kuala Lumpur',
            'Maldives' => 'Malé',
            'Mali' => 'Bamako',
            'Malta' => 'Valletta',
            'Marshall Islands' => 'Majuro',
            'Mauritania' => 'Nouakchott',
            'Mauritius' => 'Port Louis',
            'Mexico' => 'Mexico City',
            'Micronesia' => 'Palikir',
            'Moldova' => 'Chisinau',
            'Monaco' => 'Monaco',
            'Mongolia' => 'Ulaanbaatar',
            'Montenegro' => 'Podgorica',
            'Morocco' => 'Rabat',
            'Mozambique' => 'Maputo',
            'Myanmar' => 'Naypyidaw',
            'Namibia' => 'Windhoek',
            'Nauru' => 'Yaren',
            'Nepal' => 'Kathmandu',
            'Netherlands' => 'Amsterdam',
            'New Zealand' => 'Wellington',
            'Nicaragua' => 'Managua',
            'Niger' => 'Niamey',
            'Nigeria' => 'Abuja',
            'North Macedonia' => 'Skopje',
            'Norway' => 'Oslo',
            'Oman' => 'Muscat',
            'Pakistan' => 'Islamabad',
            'Palau' => 'Melekeok',
            'Palestine' => 'East Jerusalem',
            'Panama' => 'Panama City',
            'Papua New Guinea' => 'Port Moresby',
            'Paraguay' => 'Asunción',
            'Peru' => 'Lima',
            'Philippines' => 'Manila',
            'Poland' => 'Warsaw',
            'Portugal' => 'Lisbon',
            'Qatar' => 'Doha',
            'Republic of the Congo' => 'Brazzaville',
            'Romania' => 'Bucharest',
            'Russia' => 'Moscow',
            'Rwanda' => 'Kigali',
            'Saint Kitts and Nevis' => 'Basseterre',
            'Saint Lucia' => 'Castries',
            'Saint Vincent and the Grenadines' => 'Kingstown',
            'Samoa' => 'Apia',
            'San Marino' => 'San Marino',
            'São Tomé and Príncipe' => 'São Tomé',
            'Saudi Arabia' => 'Riyadh',
            'Senegal' => 'Dakar',
            'Serbia' => 'Belgrade',
            'Seychelles' => 'Victoria',
            'Sierra Leone' => 'Freetown',
            'Singapore' => 'Singapore',
            'Slovakia' => 'Bratislava',
            'Slovenia' => 'Ljubljana',
            'Solomon Islands' => 'Honiara',
            'Somalia' => 'Mogadishu',
            'South Africa' => 'Pretoria',
            'South Sudan' => 'Juba',
            'Spain' => 'Madrid',
            'Sri Lanka' => 'Sri Jayawardenapura Kotte',
            'Sudan' => 'Khartoum',
            'Suriname' => 'Paramaribo',
            'Sweden' => 'Stockholm',
            'Switzerland' => 'Bern',
            'Syria' => 'Damascus',
            'Taiwan' => 'Taipei',
            'Tajikistan' => 'Dushanbe',
            'Tanzania' => 'Dodoma',
            'Thailand' => 'Bangkok',
            'Togo' => 'Lomé',
            'Tonga' => 'Nukualofa',
            'Trinidad and Tobago' => 'Port of Spain',
            'Tunisia' => 'Tunis',
            'Turkey' => 'Ankara',
            'Turkmenistan' => 'Ashgabat',
            'Tuvalu' => 'Funafuti',
            'Uganda' => 'Kampala',
            'Ukraine' => 'Kiev',
            'United Arab Emirates' => 'Abu Dhabi',
            'United Kingdom' => 'London',
            'United States' => 'Washington DC',
            'Uruguay' => 'Montevideo',
            'Uzbekistan' => 'Tashkent',
            'Vanuatu' => 'Port Vila',
            'Venezuela' => 'Caracas',
            'Vietnam' => 'Hanoi',
            'Yemen' => 'Sana\'a', 
            'Zambia' => 'Lusaka',
            'Zimbabwe' => 'Harare'
        };
        
        countryName = countryName?.capitalize();
        String capital = '';
        if(countryCapitalMap.containsKey(countryName)){
            capital = countryCapitalMap.get(countryName);
        }
        return capital;
    }

    public static Boolean canVote(Integer age){
        if(age >= 18){
            return true;
        }
        return false;
    }

    public static Boolean isBuzzNumber(Integer num){
        String numberFromString = String.valueOf(num);
        if(numberFromString.endsWith('7')){
            return true;
        }else if(Math.mod(num, 7) == 0){
            return true;
        }
        return false;
    }

    public static Decimal grossSalary (Decimal salary){
        /**
         * Write a class in Apex with a method, pass the Basic Salary of the user, and calculate
            and print the gross salary of the user. Gross Salary = Basic Salary + Travel Allowance +
            Dearness Allowance + House Rent Allowance. If the Basic Salary is greater than or equal to
            10000, then Travel Allowance is 10% of the Basic Salary and House Rent Allowance is 20%
            of the Basic Salary. Otherwise, Travel Allowance is 15% of the Basic Salary and House Rent
            Allowance is 30% of the Basic Salary. Dearness Allowance will be 20% of the Basic Salary
            for both cases.
        */
        Decimal gross, tA, dA, hRA;
        if(salary >= 10000){
            tA = salary * 0.10;
            hRA = salary * 0.20;
        }else{
            tA = salary * 0.15;
            hRA = salary * 0.30;
        }

        dA = salary * 0.20;
        gross = salary + tA + dA + hRA;
        gross = gross.setScale(2);
        System.debug('Gross Salary of the user is ' + gross);
        return gross;
    }

    public static Decimal amountForDistance(Integer km){
        /**
         * 
         * Write a class in Apex with a method, and pass the distance traveled by the user as
            a parameter to the same method. Calculate and print the amount to pay on the following criteria.
            Kms Travelled Amount Per Km
            First 10 Kms Rs. 30/-
            Next 20 Kms Rs. 25/-
            Next 40 kms Rs. 20/-
            Next 70 Kms Rs. 15/-

        */
        Decimal finalPay;
        if(km <= 10){
            finalpay = 30 * km;
        }else if(km <= 30){
            finalPay = (30 * 10) + (25 * (km - 10));
        }else if(km <= 70){
            finalPay = (30 * 10) + (25 * 20) + (20 * (km - 30));
        }else if(km <= 140){
            finalPay = (30 * 10) + (25 * 20) + (20 * 40) + (15 * (km - 70));
        }else{
            finalPay = -1;
        }
        return finalPay;
    }

    public static Decimal taxPayable(Decimal grossSalary){
        Decimal tax;
        if(grossSalary < 100000){
            tax = 0;
        }else if(grossSalary <= 500000){
            tax = 1000 + ((grossSalary - 100000) * 0.10);
        }else if(grossSalary <= 800000){
            tax = 5000 + (400000 * 0.10) + ((grossSalary - 500000) * 0.20);
        }else{
            tax = 10000 + (400000 * 0.10) + (300000 * 0.20) + ((grossSalary - 800000) * 0.25);
        }
        system.debug('the tax paid is ' + tax);
        return tax;
    }
}