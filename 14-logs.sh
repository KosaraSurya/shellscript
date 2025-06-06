#!bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOG_FOLDER="/var/log/shellpractice"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOG_FOLDER    #-p will check whether dir is there or not, if it not exits it will create the folder.
echo "Script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR : Please proceed with root acccess$N"
    exit 1
else
    echo -e "$G Welcome to the root user$N" &>>$LOG_FILE
    #By using &>>$LOG_FILE command will not display the elog on the screen, it will only saves in file.
    echo -e "$G Welcome to the root user$N" | tee -a $LOG_FILE 
    #Tee command will display th elog on the screen as well as saves in file.
fi

VALIDATE(){
    if [ $1 -ne 0 ] 
    then
        echo -e "$R ERROR : $2 installation was failed please check $N" | tee -a $LOG_FILE
        exit 1
    else
        echo -e "$G $2 installation was successful $N"
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo -e "$Y mysql is not instlled,please proceed to install $N"
    dnf install mysql -y | tee -a $LOG_FILE
    VALIDATE $? "MYSQL"
else
    echo -e "$G mysql is already installed $N"
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo -e "$Y python3 is not instlled,please proceed to install $N"
    dnf install python3 -y | tee -a $LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "$G mypython3sql is already installed $N"
fi
