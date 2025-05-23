#!bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOG_FOLDER="/var/log/shellpractice"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"
PACKAGE=("mysql" "python3" "nginx")

mkdir -p $LOG_FOLDER    #-p will check whether dir is there or not, if it not exits it will create the folder.
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR : Please process with root access $N"
    exit 1
else
    echo -e "$G access granted please procees $N"
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

for $PACKAGE in $@
do
    dnf list installed $PACKAGE
    if [ $? -ne 0 ]
    then
        echo "$PACKAGE is not installed... going to install it" | tee -a $LOG_FILE
        dnf install $PACKAGE -y &>>$LOG_FILE
        VALIDATE $? "$PACKAGE"
    else
        echo -e "Nothing to do $PACKAGE... $Y already installed $N" | tee -a $LOG_FILE
    fi
done

