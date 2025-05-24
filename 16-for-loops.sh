#!bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOG_FOLDER="/var/log/shellpractice"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
PACKAGES    =("mysql" "python3" "nginx")

mkdir -p $LOG_FOLDER    #-p will check whether dir is there or not, if it not exits it will create the folder.
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR : Please process with root access $N"
    exit 1
else
    echo -e "$G access granted please proceed $N"
fi

# validate functions takes input as exit status, what command they tried to install
Validate(){
    if [ $1 -ne 0 ]
    then
        echo -e "$R ERROR : installation was failed $N"
        exit 1
    else
        echo -e "$G installatio was successful $N"
    fi
}

#for package in ${PACKAGES[@]}  #it will take from the declared PACKAGES array
for package in $@ #dynamically at the time of running the script we have to pass the arguments to install
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then
        echo "$package is not installed... going to install it" | tee -a $LOG_FILE
        dnf install $package -y &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "Nothing to do $package... $Y already installed $N" | tee -a $LOG_FILE
    fi
done

