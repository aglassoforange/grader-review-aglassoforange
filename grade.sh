CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# files='find ./student-submission/*.java'

# for file in $files
# do
#     if [[ -f $file ]]
#     then
#         echo 'Correct file'
#         cp ./student-submission/$file ./grading-area
#         javac $file

#     else
#         echo 'Incorrect file'
#         exit
#     fi
# done


file=`find ./student-submission/*.java`  
if [[ -f $file ]]
then
    javac $file 
    javac -cp ./lib/junit-4.13.2.jar:./lib/hamcrest-2.2.jar:. TestListExamples.java ListExamples.java 
    java -cp ./lib/junit-4.13.2.jar:./lib/hamcrest-2.2.jar:. org.junit.runner.JUnitCore TestListExamples ListExamples StringChecker > re.txt
    tests_run=$(cat re.txt | grep -oE 'Tests run: ([0-9]+)' | grep -oE '[0-9]+')
    Failures=$(cat re.txt | grep -oE 'Failures: ([0-9]+)' | grep -oE '[0-9]+')

    re=$((tests_run - Failures))
    echo "********************* Score: $re *********************"

else
    echo 'Incorrect file'
    exit
fi

# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
