/*
    Group Number: 2

    Name   :Pawan Deep
    ID     :111144218
    Name   :Anmoldeep Singh
    ID     :142668201
    Name   :Harsh Rajeshkumar Sheth
    ID     :55198203
    Name   :Kinnari Rajendrakumar Patel
    ID     :149399206
    Name   :Prince Harshadbhai Bhingradiya
    ID     :159072206
*/
#define _CRT_SECURE_NO_WARNINGS
/*system libraries */
#include <iostream>
#include <occi.h>

/* user libraries */
#include <iomanip>
#include <cstring>

/* struct defintion */
struct Employee
{
    //employee infortmation
    int employeeNumber;
    char lastName[50];
    char firstName[50];
    char email[100];
    char phone[50];
    char extension[10];
    char reportsTo[100];
    char jobTitle[50];
    char city[50];
};
//using namespace for the database and  standard
using namespace oracle::occi;
using namespace std;

/* function prototypes */

int menu(void); // shows main menu to the user interface
int findEmployee(Connection* conn, int employeeNumber, struct Employee* emp); // find the employee from the database
void displayEmployee(Connection* conn, struct Employee* emp);// dispaly the employee details
void displayAllEmployees(Connection* conn); // Display details of all the employee in the database
//second milestone
void insertEmployee(struct Employee* emp); // get the new employee infomation
void insertEmployee(Connection* conn, struct Employee emp); // insert new employee to the database
void updateEmployee(Connection* conn, int employeeNumber);// update an employee information to the database
int getEmployeeNumber(); // validates if the employee with the given employee number exsist or not
void deleteEmployee(Connection* conn, int employeeNumber);// delete an employee from the database 

/* main begins execution */
int main()
{
    //OCCI Variables
    Environment* env = nullptr;
    Connection* conn = nullptr;
    /* creating connection to database */
    //variables for connection
    string usr = "dbs211_221i08"; //User ID for the connection 
    string pass = "25442202";     //required Password of the user for connection 
    string srv = "myoracle12c.senecacollege.ca:1521/oracle12c"; //Database server 
    //connection to database
    env = Environment::createEnvironment(Environment::DEFAULT);
    conn = env->createConnection(usr, pass, srv);
    Employee* emp = new Employee;
    struct Employee employee = {};
    int choiceNum = -1;// user choice number from(0-5)
    while (choiceNum != 0) // If the choice is true user enters
    {
        choiceNum = menu(); // User see the menu from the function menu
        switch (choiceNum) // User makes the choice
        {
        case 0:// exit if user choice is 0
            cout << "Exiting the database!!!" << endl;
            break;

        case 1:// display the chosen employee if 1 is entered
            int num;
            int found;
            cout << "Enter Employee Number: "; // User enters the emplyoee number
            while (!(cin >> num)) // If the employee number dosen't exsist
            {
                cin.clear();
                cin.ignore(1000, '\n'); // finish the input whovever comes first 1000 digits for the number or '\n'
                cout << "Invalid input.  Try again: "; // shows the error
            }
            found = findEmployee(conn, num, emp); // find the employee number with the help of function findEmployee()
            if (found == 1)
            {
                displayEmployee(conn, emp); // If the employee is found shows the employee detail with the function displayEmployee()
            }
            if (found == 0)
            {
                cout << "Employee " << num << " does not exist." << endl; // If the employee number is not found shows this error message
            }
            break;

        case 2:
            //display all the employees with the help of function displayAllEmployees() 
            displayAllEmployees(conn);
            break;

        case 3: // User enters 3 to insert a new employee
            insertEmployee(&employee); // user enter new employee with the help of function insertEmployee()
            if (findEmployee(conn, employee.employeeNumber, &employee) != 1) // If the employee number is unique
            {
                insertEmployee(conn, employee); // user added the new employee successfully into the databse with the function
            }
            else // If there is already one employee with the same number
            {
                cout << endl;
                cout << "An employee with the same employee number exists."; // error message displayed
                cout << endl << endl;
            }
            break;
        case 4: // user enters 4 to update an employee number
        {
            int employeeNumber = getEmployeeNumber(); // user enters employee number and get the employee from the database
            updateEmployee(conn, employeeNumber); // user updates the employee information with the help of function updateEmployee();
            break;
        }
        case 5:// user enters 5 to delete an employee from the database
        {
            int employeeNumber = getEmployeeNumber(); // User enters and the employee number from the database with the function getEmployeeNumber
            deleteEmployee(conn, employeeNumber); // User delets the employee with the help of function deleteEmploye()
            break;
        }
        default:
            //if entered value isn't between 0 and 5
            cout << "You need to enter a number between 0 and 5" << endl; // error message shows if the user enter value isn't between 0 and 5
            break;
        }
    }
}

/* cascading menu system */
int menu(void)
{
    //prints the menu and show it to the user interface
    int opt = -1;
    cout << "********************* HR Menu *********************" << endl << endl;
    cout << "1) Find Employee" << endl;
    cout << "2) Employees Report" << endl;
    cout << "3) Add Employee" << endl;
    cout << "4) Update Employee" << endl;
    cout << "5) Remove Employee" << endl;
    cout << "0) Exit" << endl;
    cout << endl;
    cout << "Enter an option (0-5) : ";

    while (!(cin >> opt)) // If the entered value isn't a valid value 
    {
        cin.clear();
        cin.ignore(1000, '\n');
        cout << "Invalid input. Try again: ";  // shows the error message for the invalid value
    }
    return opt;
}

/* this function returns 0 if the employee does not exist else returns 1 if the employee exists */
int findEmployee(Connection* conn, int employeeNumber, struct Employee* emp)
{
    // checking if the employeenumber exists
    //define a reference to an object statement
    Statement* stmt = conn->createStatement();
    // statement to get the required employee number from the database
    string chck = "SELECT COUNT(*) FROM employees WHERE employeenumber = " + to_string(employeeNumber);
    // after getting the employee number the result is stored in an object resultset
    ResultSet* ck = stmt->executeQuery(chck);

    int i = 0;
    while (ck->next())
    {
        i = ck->getInt(1);
        if (i == 0)// will check if the employeenumber does not exist and will return 0
        {
            // If the resultset is empty
            conn->terminateStatement(stmt);
            return 0;
        }
    }
    try
    {
        //If the resultset is not empty execute the query
        ResultSet* rs = stmt->executeQuery("SELECT e.lastname, e.firstname, e.extension, e.email, m.firstname || ' ' || m.lastname as reportsto, e.jobtitle, o.phone, o.city FROM employees e LEFT JOIN employees m ON e.reportsto=m.employeenumber LEFT JOIN offices o ON o.officecode=e.officecode WHERE e.employeenumber = " + to_string(employeeNumber));

        while (rs->next())
        {
            //assigning values to local variables
            string lastname = rs->getString(1);
            string firstname = rs->getString(2);
            string extension = rs->getString(3);
            string email = rs->getString(4);
            string man_name = rs->getString(5);
            string jobtitle = rs->getString(6);
            string phone = rs->getString(7);
            string city = rs->getString(8);
            //assigning values to the structure
            emp->employeeNumber = employeeNumber;
            strcpy(emp->lastName, lastname.c_str());
            strcpy(emp->firstName, firstname.c_str());
            strcpy(emp->extension, extension.c_str());
            strcpy(emp->email, email.c_str());
            strcpy(emp->reportsTo, man_name.c_str());
            strcpy(emp->jobTitle, jobtitle.c_str());
            strcpy(emp->phone, phone.c_str());
            strcpy(emp->city, city.c_str());
        }
        conn->terminateStatement(stmt); //terminate the Statement object
        return 1;
    }
    // Error
    catch (SQLException& sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
}

/* this function displays employee's information and if the given employee number doesn't exist then the function displays error message */
void displayEmployee(Connection* conn, struct Employee* emp)
{
    // Display the employee details that has been fetched from the databse to the user interface
    printf("\nemployeeNumber = %d\nLast Name = %s\nFirst Name = %s\nEmail = %s\nPhone = %s\nExtension = %s\nReportsTo = %s\nJobTitle = %s\nCity = %s\n\n", emp->employeeNumber, emp->lastName, emp->firstName, emp->email, emp->phone, emp->extension, emp->reportsTo, emp->jobTitle, emp->city);
}

/* this function displays the following attributes for all employees  */
void displayAllEmployees(Connection* conn)
{
    try
    {
        Statement* stmt = conn->createStatement();// needed query is used
        // executing the query and store the resultset
        ResultSet* rs = stmt->executeQuery("SELECT e.employeenumber, e.lastname || ' ' || e.firstname AS fullname, e.extension, e.email, m.firstname || ' ' || m.lastname AS man_fullname, o.phone FROM employees e LEFT JOIN employees m ON e.reportsto=m.employeenumber LEFT JOIN offices o ON o.officecode=e.officecode ORDER BY e.employeenumber");

        cout << left << setw(10) << "E" << setw(25) << "Employee Name" << left << setw(34) << "Email" << left << setw(27) << "Phone" << left << setw(15) << "Ext" << left << setw(26) << "Manager" << endl;
        cout << "--------------------------------------------------------------------------------------------------------------------------------" << endl;

        while (rs->next())// following coloum recieved desire datatype result
        {
            // getting the required resultset from the database and displaying it
            int employeenumber = rs->getInt(1);
            string fullname = rs->getString(2);
            string extension = rs->getString(3);
            string email = rs->getString(4);
            string reportsto = rs->getString(5);
            string phone = rs->getString(6);


            cout << left << setw(10) << employeenumber << left << setw(25) << fullname << left << setw(34) << email << left << setw(27) << phone << left << setw(15) << extension << left << setw(26) << reportsto << endl;
        }
        //terminate the Statement object
        conn->terminateStatement(stmt);
        cout << endl;
    }
    // If error occurs display the message
    catch (SQLException& sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
}
/* this function get new employees information */
void insertEmployee(struct Employee* emp)
{
    std::cout << "-------------- New Employee Information --------------" << endl << endl;
    cout << "Employee Number : ";
    cin >> emp->employeeNumber; // get the employee number
    cout << "Last Name : ";
    cin >> emp->lastName; // get the employee last name
    cout << "First Name : ";
    cin >> emp->firstName; // get the employee first name
    cout << "Email : ";
    cin >> emp->email; // get the employee email
    cout << "Extension : ";
    cin >> emp->extension; // get the employee extension
    cout << "Job Title : ";
    cin >> emp->jobTitle; // get the employee job title
}

/* this function inserts employees information into the database */
void insertEmployee(Connection* conn, struct Employee emp)
{
    try {
        Statement* stmt = conn->createStatement();


        /* execute a query and store a result into a result set object */
        stmt->setSQL("INSERT INTO employees(employeenumber, lastname, firstname, email, extension, jobtitle, officecode)  VALUES (:1, :2, :3, :4, :5, :6, :7)");
        // enter the new employee detalils that is needed to add to the database
        stmt->setInt(1, emp.employeeNumber);
        stmt->setString(2, emp.lastName);
        stmt->setString(3, emp.firstName);
        stmt->setString(4, emp.email);
        stmt->setString(5, emp.extension);
        stmt->setString(6, emp.jobTitle);
        stmt->setInt(7, 1);// added default value as officecode 1

        stmt->executeUpdate(); // update the database with the new employee


        cout << endl;
        cout << "The new employee is added successfully." << endl; // shows the message if the employee is addd sucessfully

        conn->commit(); // commit to save the changes in the database

        conn->terminateStatement(stmt); //terminate the Statement object
    }
    //If error occurs display the message
    catch (SQLException& sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
}

/* this function updates information to the existing employee */
void updateEmployee(Connection* conn, int employeeNumber)
{
    try
    {
        struct Employee emp = {};

        /* If employee number exists */
        if (findEmployee(conn, employeeNumber, &emp) == 1)
        {
            cout << "New Extension : ";
            cin >> emp.extension; // employee enters the new extension
            // statement execution to update the new extension
            Statement* stmt = conn->createStatement("UPDATE employees SET extension  = :1 "
                "WHERE employeenumber = :2");

            stmt->setString(1, emp.extension);
            stmt->setInt(2, employeeNumber);
            stmt->executeQuery();
            // diaplay the message if the employee extension is updated sucessfully
            cout << endl;
            cout << "The employee's extension is updated successfully." << endl << endl;

            conn->commit(); // save the changes with the commit into the database
            conn->terminateStatement(stmt); //terminate the Statement object
        }
        else
        {
            /* If employee number doesn't exist */
            cout << endl;
            cout << "The employee with ID " << employeeNumber << " does not exist." << endl << endl;
        }
    }
    //If error occurs display the message
    catch (SQLException& sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
}

/* this function validates whether the employee exists or not */
int getEmployeeNumber()
{
    int employeeNumber;
    cout << endl;
    cout << "Enter Employee Number : ";
    cin >> employeeNumber; //, get the employee number
    // If the employee number is not found in the database
    while (cin.fail())
    {
        cout << endl;
        cout << "Invalid employee number try again please : "; // error message 
        cin.clear();
        cin.ignore(5000, '\n');
        cin >> employeeNumber; // get the employee number
    };
    cin.ignore();
    return employeeNumber; // return the employee number if it is found in the database
}

/* this function deletes employees information from the database */
void deleteEmployee(Connection* conn, int employeeNumber)
{
    try
    {
        struct Employee emp = {};

        /* If employee number exists */
        if (findEmployee(conn, employeeNumber, &emp) == 1)
        {
            // statement execution to delete the employee number from the database
            Statement* stmt = conn->createStatement("DELETE FROM EMPLOYEES WHERE employeenumber = :1 ");
            stmt->setInt(1, employeeNumber);
            stmt->executeQuery();
            // display the message if the employee has been removed successfully
            cout << endl;
            cout << "The employee has been removed successfully." << endl << endl;

            conn->commit(); // use commit to save the changes to the database
            conn->terminateStatement(stmt); //terminate the Statement object
        }
        else
        {
            /* If employee number does not exist display an error message*/
            cout << endl;
            cout << "The employee with ID " << employeeNumber << " does not exist.";
            cout << endl << endl << endl;
        }
    }
    //If error occurs display the message
    catch (SQLException& sqlExcp)
    {
        cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
    }
}