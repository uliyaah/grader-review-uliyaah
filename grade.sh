CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

submission=`find student-submission -name "*.java"`

if [[ $submission == "student-submission/ListExamples.java" ]]
    then 
        cp -r $submission grading-area
    else
        echo "Incorrect file submitted"
        echo "You failed... :(, 0%"
        exit
fi

echo $submission

cp TestListExamples.java grading-area
cp -r lib grading-area


cd grading-area
ls 

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2> error.txt


errorCode=`echo $?`

 if [[ $errorCode -eq 0 ]]
     then 
         echo "Finished Compiling" 
         java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > results.txt
         

     else
         echo "ERROR: Did not compile!"
         echo "You failed... :(, 0%"
         exit
 fi

grade=`grep OK results.txt`
# after the given string it find any digit between 0-9 and awk saves the value at that column
tests=`grep -o 'Tests run: \([0-9]*\)' results.txt | awk '{print $3}'` 
failure=`grep -o 'Failures: \([0-9]*\)' results.txt | awk '{print $2}'`


# echo "Test run: 4, Failures: 1" | grep -oP 'Test run: \K\d+' && echo " " && echo "Test run: 4, Failures: 1" | grep -oP 'Failures: \K\d+'

if [[ $grade != "OK (1 test)" ]]
    then
        grade=`echo "($tests-$failure)/$tests*100"| bc`
        echo "You got $grade%"
    else
        echo "CONGRATS! U GOT 100% :)"
fi 


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
