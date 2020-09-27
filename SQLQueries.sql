                                                                                                                                   SQL COMMANDS
    Query all columns for all American cities in CITY with populations larger than 100000. The CountryCode for America is USA.
select * from city where population>100000 and countrycode='USA';

   Query the names of all American cities in CITY with populations larger than 120000. The CountryCode for America is USA.
select name from city where population>120000 and countrycode='USA';
   
     Query all columns (attributes) for every row in the CITY table.
select * from city;

      Query all columns for a city in CITY with the ID 1661.
select * from city where ID=1661;

    Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN
select * from city where countrycode='JPN';

     Query a list of CITY and STATE from the STATION table.
select city,state from station;

      Query a list of CITY names from STATION with even ID numbers only. You may print the results in any order, but must exclude duplicates from your answer.
SELECT distinct city
FROM station where (id%2)=0;

    Let  N be the number of CITY entries in STATION, and let N' be the number of distinct CITY names in STATION; query the value of  from N-N'
 STATION. In other words, find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
select count(CITY)-count(distinct CITY) from station;

     Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
/* FOR FIRST QUERY */ SELECT CITY,LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) ASC,CITY ASC LIMIT 1;
/* FOR SECOND QUERY */ SELECT CITY,LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC,CITY DESC LIMIT 1;
    
      starting with vowel:
select distinct city from station where city rlike '^[aeiou]';
or
SELECT DISTINCT CITY FROM STATION WHERE LEFT(CITY,1) IN ('a','i','e','o','u');

where like 'p%'     '%p'     '__p%'   '%p%'

   ending
select distinct city from station where city rlike '[aeiou]$';
or
SELECT DISTINCT CITY FROM STATION WHERE RIGHT(CITY,1) IN ('a','i','e','o','u');

   both
 select distinct city from station where LEFT(CITY,1) IN ('a','i','e','o','u') and RIGHT(CITY,1) IN ('a','i','e','o','u');
or
select distinct city from station where city rlike '^[aeiou]' &&     (or )   and   city rlike '[aeiou]$' ;
   not start
select distinct city from station where  not city rlike '^[aeiou]';        (or)
select distinct city from station where city rlike '^[^aeiou]';
select distinct city from station where  city rlike '^[^aeiou]' || city rlike '[^aeiou]$' ;

     Query the Name of any student in STUDENTS who scored higher than  75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
SELECT NAME FROM STUDENTS WHERE MARKS > 75 ORDER BY RIGHT(NAME, 3), ID ASC;

  Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
select name from  Employee order by name asc;

  Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  2000 per month who have been employees for less than 10  months. Sort your result by ascending employee_id.
select name from employee where salary > 2000 && months < 10 order by employee_id asc;

  
    Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

    Equilateral: It's a triangle with 3 sides of equal length.
    Isosceles: It's a triangle with 2 sides of equal length.
    Scalene: It's a triangle with 3 sides of differing lengths.
    Not A Triangle: The given values of A, B, and C don't form a triangle.
select case when A+B > C AND A=B AND B=C AND A=C then 'Equilateral' when A+B > C AND A=B OR B=C OR A=C then 'Isosceles' when A+B > C AND A!=B and b!=c then 'Scalene' else 'Not A Triangle' End from TRIANGLES;

Generate the following two result sets:

    Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

    Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format: 

SELECT concat(NAME, CASE WHEN occupation = "Doctor" THEN "(D)" WHEN occupation = "Professor" THEN "(P)" WHEN occupation = "Singer" THEN "(S)" WHEN occupation = "Actor" THEN "(A)" END ) FROM OCCUPATIONS ORDER BY NAME,OCCUPATION;
SELECT "There are a total of", COUNT(OCCUPATION), concat(LOWER(OCCUPATION),"s.") FROM OCCUPATIONS GROUP BY OCCUPATION ORDER BY COUNT(OCCUPATION) ASC, OCCUPATION ASC;

Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

Note: Print NULL when there are no more names corresponding to an occupation.

set @r1=0, @r2=0, @r3=0, @r4=0;
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(
  select case when Occupation='Doctor' then (@r1:=@r1+1)
            when Occupation='Professor' then (@r2:=@r2+1)
            when Occupation='Singer' then (@r3:=@r3+1)
            when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
  from OCCUPATIONS
  order by Name
) Temp
group by RowNumber

You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

    Root: If node is root node.
    Leaf: If node is leaf node.
    Inner: If node is neither root nor leaf node.

SELECT N , CASE WHEN P IS NULL THEN 'Root' ELSE CASE WHEN EXISTS (SELECT P FROM BST B WHERE A.N=B.P) THEN 'Inner' ELSE 'Leaf' END END FROM BST A ORDER BY N


    
         Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.
select c.company_code, c.founder, count(distinct lm.lead_manager_code), 
count(distinct sm.senior_manager_code), count(distinct m.manager_code), 
count(distinct e.employee_code) from Company c, Lead_Manager lm, Senior_Manager sm, Manager m, Employee e
where c.company_code = lm.company_code
    and lm.lead_manager_code = sm.lead_manager_code
    and sm.senior_manager_code = m.senior_manager_code
    and m.manager_code = e.manager_code
group by c.company_code, c.founder
order by c.company_code

      
      Query a count of the number of cities in CITY having a Population larger than  100000.
select count(id) from city where population>100000;
     
    Query the total population of all cities in CITY where District is California. 
select sum(population) from city where district='california';
   
       Query the average population of all cities in CITY where District is California.
select avg(population) from city where district='california';

       Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT ROUND(AVG(POPULATION)-0.5) FROM CITY;
or
SELECT FLOOR(AVG(POPULATION)) FROM CITY;

Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
select c.continent,floor(avg(ci.population)) as 'avg_population'
from city ci
inner join country c
ON ci.countrycode = c.code
group by c.continent;
or
SELECT COUNTRY.Continent,ROUND(AVG(city.POPULATION)-0.5) FROM CITY,country where CITY.CountryCode = COUNTRY.Code group by country.continent;


       Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.      
select sum(population) from city where countrycode='jpn';


  Query the difference between the maximum and minimum populations in CITY.
select max(population)-min(population) from city;

   Query the following two values from the STATION table:

    The sum of all values in LAT_N rounded to a scale of 2 decimal places.
    The sum of all values in LONG_W rounded to a scale of 2 decimal places.
select round(sum(lat_n),2),round(sum(long_w),2) from station;


Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard s 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeroes removed), and the actual average salary.

Write a query calculating the amount of error (i.e.: actual miscalculated average monthly salaries), and round it up to the next integer.
SELECT CEILING(AVG(SALARY) - AVG(REPLACE(SALARY,'0','') )) FROM Employees;


We define an employees total earnings to be their monthly salary* months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.
select (salary * months)as earnings ,count(*) from employee group by 1 order by earnings desc limit 1;

 Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to decimal places.
SELECT TRUNCATE(SUM(LAT_N), 4)
  FROM STATION
 WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

  Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345 . Truncate your answer to 4 decimal places.
select truncate(max(lat_n),4) from station where lat_n < 137.2345;

Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345 . Round your answer to 4 decimal places.
select round(long_w,4) from station where lat_n=(select max(lat_n) from station where lat_n<137.2345);


    Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7780. Round your answer to 4 decimal places.
SELECT ROUND(MIN(LAT_N),4)
FROM STATION
WHERE LAT_N>38.7780;

Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780 . Round your answer to 4 decimal places.
select round(long_w,4) from station where lat_n =(select min(lat_n) from station where lat_n> 38.7780);


Consider P1(a,b) and P2(c,d)to be two points on a 2D plane.
a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
  b  happens to equal the minimum value in Western Longitude (LONG_W in STATION).
   c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
   d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
Query the Manhattan Distance between points P1and P2 and round it to a scale of 4 decimal places.
select round(max(lat_n)- min(lat_n) + max(long_w)-min(long_w),4) from station;


     Consider P1(a,c)and P2(b,d)to be two points on a 2D plane where (a,b)are the respective minimum and maximum values of Northern Latitude (LAT_N) and (c,d)are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.
Query the Euclidean Distance between points P1 and P2 and format your answer to display 4 decimal digits.
select round(sqrt(power(max(lat_n)- min(lat_n),2) +power(max(long_w)-min(long_w),2)),4) from station;

A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places. 
select round(s.lat_n,4) from station s where (select round(count(s.id)/2)-1 from station) = (select count(s1.id) from station s1 where s1.lat_n > s.lat_n);

You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
Select S.Name
From ( Students S join Friends F Using(ID)
       join Packages P1 on S.ID=P1.ID
       join Packages P2 on F.Friend_ID=P2.ID)
Where P2.Salary > P1.Salary
Order By P2.Salary;


Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
select sum(city.population) from city,country where country.continent='asia' && country.code=city.countrycode;

Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
Note: CITY.CountryCode and COUNTRY.Code are matching key columns.
select  city.name from city,country where country.continent='africa' && country.code=city.countrycode;


select (case when grade >=8 then name else null end) name, grade, marks from (select s.name, g.grade, s.marks from students s join grades g on s.marks between g.min_Mark and g.Max_Mark) order by grade desc, name;
SELECT (CASE g.grade>=8 WHEN TRUE THEN s.name ELSE null END),g.grade,s.marks FROM students s INNER JOIN grades g ON s.marks BETWEEN min_mark AND max_mark ORDER BY g.grade DESC,s.name,s.marks;
or
SELECT (CASE g.grade>=8 WHEN TRUE THEN s.name ELSE null END),g.grade,s.marks FROM students s,grades g  where s.marks BETWEEN g.min_mark AND g.max_mark ORDER BY g.grade DESC,s.name,s.marks;
or
SELECT Name,Grade,Marks FROM Students,Grades WHERE Marks BETWEEN Min_Mark AND Max_Mark and Grade>=8 ORDER BY Grade desc,Name;
SELECT null,Grade,Marks FROM Students,Grades WHERE Marks BETWEEN Min_Mark AND Max_Mark and Grade<8 ORDER BY Grade desc,Name,Marks;

Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
select h.hacker_id, h.name
from submissions s
inner join challenges c
on s.challenge_id = c.challenge_id
inner join difficulty d
on c.difficulty_level = d.difficulty_level 
inner join hackers h
on s.hacker_id = h.hacker_id
where s.score = d.score and c.difficulty_level = d.difficulty_level
group by h.hacker_id, h.name
having count(s.hacker_id) > 1
order by count(s.hacker_id) desc, s.hacker_id asc

Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Rons interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

SELECT temp2.I, temp2.A, temp2.WNN, temp2.P FROM (SELECT MIN(W1.COINS_NEEDED) AS WN, WP1.AGE as AG, W1.POWER AS PW FROM WANDS W1 INNER JOIN WANDS_PROPERTY WP1 ON W1.CODE=WP1.CODE 
 GROUP BY W1.POWER, WP1.AGE ORDER BY W1.POWER DESC, WP1.AGE DESC) temp1
INNER JOIN
(SELECT W.ID AS I, MIN(W.COINS_NEEDED) AS WNN, WP.AGE as A, W.POWER AS P  FROM WANDS W INNER JOIN WANDS_PROPERTY WP ON W.CODE=WP.CODE 
WHERE WP.IS_EVIL=0
GROUP BY W.POWER, WP.AGE, W.ID ORDER BY W.POWER DESC, WP.AGE DESC) temp2
ON temp1.WN=temp2.WNN AND temp1.PW=temp2.P AND temp1.AG=temp2.A;

Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
select H.hacker_id, H.name, count(*) as total
from Hackers H, Challenges C
where H.hacker_id = C.hacker_id
group by H.hacker_id, H.name
having total = 
    (select count(*) 
     from challenges
     group by hacker_id 
     order by count(*) desc limit 1
     )
or total in
    (select total
     from (
        select count(*) as total
        from Hackers H, Challenges C
        where H.hacker_id = C.hacker_id
        group by H.hacker_id, H.name
      ) counts
     group by total
     having count(*) = 1)
order by total desc, H.hacker_id asc
;

You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  0 from your result.
select h.hacker_id, name, sum(score) as total_score
from
hackers as h inner join
/* find max_score*/
(select hacker_id,  max(score) as score from submissions group by challenge_id, hacker_id) max_score

on h.hacker_id=max_score.hacker_id
group by h.hacker_id, name

/* don't accept hackers with total_score=0 */
having total_score > 0

/* finally order as required */
order by total_score desc, h.hacker_id
;

Write a query to print all prime numbers less than or equal to 1000 . Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
For example, the output for all prime numbers  <=10 would be:
select '2&3&5&7&11&13&17&19&23&29&31&37&41&43&47&53&59&61&67&71&73&79&83&89&97&101&103&107&109&113&127&131&137
&139&149&151&157&163&167&173&179&181&191&193&197&199&211&223&227&229&233&239&241&251&257&263&269&271&277
&281&283&293&307&311&313&317&331&337&347&349&353&359&367&373&379&383&389&397&401&409&419&421&431&433&439
&443&449&457&461&463&467&479&487&491&499&503&509&521&523&541&547&557&563&569&571&577&587&593&599&601&607
&613&617&619&631&641&643&647&653&659&661&673&677&683&691&701&709&719&727&733&739&743&751&757&761&769&773
&787&797&809&811&821&823&827&829&839&853&857&859&863&877&881&883&887&907&911&919&929&937&941&947&953&967
&971&977&983&991&997';

You are given a table, Functions, containing two columns: X and Y.

Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X.
SELECT f1.X, f1.Y FROM Functions f1
INNER JOIN Functions f2 ON f1.X=f2.Y AND f1.Y=f2.X
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X)>1 or f1.X<f1.Y
ORDER BY f1.X 

Julia conducted a  15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
Write a query to print total number of unique hackers who made at least  1 submission each day (starting on the first day of the contest), and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.
select 
submission_date ,
( SELECT COUNT(distinct hacker_id)  
 FROM Submissions s2  
 WHERE s2.submission_date = s1.submission_date AND    (SELECT COUNT(distinct s3.submission_date) FROM      Submissions s3 WHERE s3.hacker_id = s2.hacker_id AND s3.submission_date < s1.submission_date) = dateDIFF(s1.submission_date , '2016-03-01')) ,
(select hacker_id  from submissions s2 where s2.submission_date = s1.submission_date 
group by hacker_id order by count(submission_id) desc , hacker_id limit 1) as shit,
(select name from hackers where hacker_id = shit)
from 
(select distinct submission_date from submissions) s1
group by submission_date
