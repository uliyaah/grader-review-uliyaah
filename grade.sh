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
        exit
fi

echo $submission

cp TestListExamples.java grading-area

cd grading-area

javac ListExamples.java TestListExamples.java > error.txt
cat error.txt
errorCode=`cat error.txt`


echo $errorCode


if [[ $errorCode == "" ]]
    then 
        echo "Finished Compiling" 
        javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
        java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples

    else
        echo "ERROR: Did not compile!"
        exit
fi






# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
