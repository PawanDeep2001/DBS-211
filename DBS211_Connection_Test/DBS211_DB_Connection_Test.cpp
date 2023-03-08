/*
Name: Pawan Deep
id: 111144218
Name: Tarlok Kaur
id: 159117209
Name: Anmoldeep Singh
id: 142668201
Name: Pushpinder Kaur
id: 141578203
Name: Ajitpal Singh
id: 113194211
*/
#define _CRT_SECURE_NO_WARNINGS
#include <iostream>
#include <occi.h>
#include <iomanip>// manipulator 
#include <cctype>// character handling function

using oracle::occi::Environment;
using oracle::occi::Connection;
// using namespace for the database and standard
using namespace oracle::occi;
using namespace std;

int mainMenu();// show the main menu to the user interface
int customerLogin(Connection* conn, int customerId);//checks if the customer does exist in the database
int addToCart(Connection* conn, struct ShoppingCart cart[]);//save the product entered by the user in the shoppin cart
double findProduct(Connection* conn, int product_id);//helps to find the product from the database
void displayProducts(struct ShoppingCart cart[], int productCount);// display the detail of the product enetered
int checkout(Connection* conn, struct ShoppingCart cart[], int customerId, int productCount);// ask the user for conformation to end the shoping

struct ShoppingCart { // created a structure that have following variable
	int product_id;
	double price;
	int quantity;
};
// main execution start from here
int main(void) {
	//OCCI Variables
	Environment* env = nullptr;
	Connection* conn = nullptr;
	//User varibale for connection
	string user = "dbs311_222d05";
	string pass = "28350105";
	string constr = "myoracle12c.senecacollege.ca:1521/oracle12c";
	try {// try and the catch method is used

		// environment to manage memory and other resources of OCCI objects
		env = Environment::createEnvironment(Environment::DEFAULT);
		conn = env->createConnection(user, pass, constr);
		int ans = -1;
		int id;
		ans = mainMenu();
		while (ans == 1) { // loop continue untill the answer is 1
			//prompting from user to enter the ID
			cout << "Enter the customer ID: ";
			cin >> id;
			if (customerLogin(conn, id) == 0) {// checking if customer exist or not
				cout << "The customer does not exist." << endl;
			}
			else {

				ShoppingCart arr[5];// create an instance of shopping cart
				int out = addToCart(conn, arr);// call the add to cart function
				displayProducts(arr, out);//display the products 
				checkout(conn, arr, id, out);//call the checkout function
			}
			ans = mainMenu();
		}
		cout << "Good bye!..." << endl;
		// These both are used to terminate the connection when we are done 
		env->terminateConnection(conn);
		Environment::terminateEnvironment(env);
	}
	catch (SQLException& sqlExcp) {
		// used to diasply error msg if code is wrong
		cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}
	return 0;
}
// menu system
int mainMenu(void) {
	int ans = 0;
	//prints the menu and ask the user to login or exit
	cout << "******************** Main Menu ********************" << endl << "1)      Login" << endl << "0)      Exit" << endl;
	cout << "Enter an option (0-1): ";
	cin >> ans;
	while (ans != 0 && ans != 1) {
		//if wrong option is selected then this is will display 
		cout << "******************** Main Menu ********************" << endl << "1)      Login" << endl << "0)      Exit" << endl;
		cout << "You entered a wrong value. Enter an option (0-1): ";
		cin >> ans;
	}
	return ans;
}
int customerLogin(Connection* conn, int customerId) {
	int output = 0;
	Statement* stmt = conn->createStatement();
	try {
		stmt->setSQL("BEGIN find_customer(:1, :2); END;");// execute the SQL statement
		stmt->setInt(1, customerId);// set the first parameter to customer ID
		stmt->setInt(2, 0);// set the second parameter to 0
		stmt->executeUpdate();//execute the update 
		output = stmt->getInt(2);//set the output variable to result of the procedure 
		conn->terminateStatement(stmt);// connection is terminated
	}
	catch (SQLException& sqlExcp) {
		// if something is worng with code then this will execute
		cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}
	return output;
}

int addToCart(Connection* conn, struct ShoppingCart cart[]) {
	cout << "-------------- Add Products to Cart --------------" << endl;
	bool ans = true;
	int i = 0;
	while (ans == true && i < 5) {//loop untill value is true and i is less than 5
		// variables are declared
		int id;
		int quantity;
		double out = 0;
		int res = -1;
		ShoppingCart item;
		try {
			cout << "Enter the product ID: ";
			cin >> id;// prompt to enter ID
			out = findProduct(conn, id); // set the result of findProduct to out variable 
			while (out == 0) {//loop untill user enter correct value
				cout << "The product does not exist. Try again..." << endl;
				cout << "Enter the product ID: ";
				cin >> id;// prompt to enter ID
				out = findProduct(conn, id); // set the result of findProduct to out variable 
			} // product matches display the following lines
			cout << "Product Price: " << out << endl;
			cout << "Enter the product Quantity: ";
			cin >> quantity;//  prompt to enter qunatity

			// set id,out,quantity into struct item variables
			item.product_id = id;
			item.price = out;
			item.quantity = quantity;
			cart[i] = item;
			if (i < 4)// try the following code for 4 times
			{
				cout << "Enter 1 to add more products or 0 to checkout: ";
				cin >> res;// prompt user to enter from 2 option 0 or 1
				while (res != 1 && res != 0) {
					cout << "Error enter 1 to add or 0 to checkout: ";
					cin >> res;
				}
				if (res == 0) {// loop teminate if te user enter 0
					ans = false;
				}
			}
			i++;
		}
		catch (SQLException& sqlExcp) {
			// if something is worng with code then this will execute
			cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
		}
	}
	return i;
}

double findProduct(Connection* conn, int product_id) {
	//parameters are reference variable to oracle database and int value as product Id
	double price = 0;//store prize as double
	Statement* stmt = conn->createStatement();//define a reference to an object statement and call method create statement() to create statement
	try {
		stmt->setSQL("BEGIN find_product(:1, :2); END;");
		//this function calss the findproduct procedure, which recevies product id and returns price
		stmt->setInt(1, product_id);
		stmt->setDouble(2, 0);
		stmt->executeUpdate();
		price = stmt->getDouble(2);//
		conn->terminateStatement(stmt);// to terminate statement
	}
	catch (SQLException& sqlExcp) {//sql exception used to display error
		cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
	}
	return price;
}

void displayProducts(struct ShoppingCart cart[], int productCount) {
	//receives an array of type shopping cart and no of products ordered as paramenters
		//displays product id,price and quantity for products stored in the array
	if (productCount != 0) {
		double sum = 0;
		cout << "------- Ordered Products ---------" << endl;
		for (int i = 0; i < productCount; i++) {
			cout << "---Item " << i + 1 << endl << "Product ID: " << cart[i].product_id << endl << "Price: " << cart[i].price << endl << "Quantity: " << cart[i].quantity << endl;
			sum += cart[i].price * cart[i].quantity;
			//to display total order amount
		}
		cout << "----------------------------------" << endl << "Total: " << sum << endl;
	}
}

int checkout(Connection* conn, struct ShoppingCart cart[], int customerId, int productCount) {
	//receives variable reference to oracle database, arrof type shopping cart, customer id as an integer and no of items
	char ans;
	Statement* stmt = conn->createStatement();//to  create connection
	cout << "Would you like to checkout ? (Y / y or N / n) ";
	cin >> ans;
	while (ans != 'y' && ans != 'Y' && ans != 'n' && ans != 'N') {
		cout << "Wrong input. Try again..." << endl << "Would you like to checkout ? (Y / y or N / n) ";
		cin >> ans;
	}
	if (ans == 'n' || ans == 'N') {
		cout << "The order is cancelled." << endl;
		return 0;
	}
	else {//if yes, proceeds to add order, which  will add a row in the orders table with the new order id.
		//it returns an orderid which is used to store ordered items in order_items table
		try {
			stmt->setSQL("BEGIN add_order(:1, :2); END;");
			int order_id;
			stmt->setInt(1, customerId);
			stmt->setInt(2, 0);

			stmt->executeUpdate();
			conn->commit();
			order_id = stmt->getInt(2);
			for (int i = 0; i < productCount; i++) {
				stmt->setSQL("BEGIN add_order_item(:1, :2, :3, :4, :5); END;");
				stmt->setInt(1, order_id);
				stmt->setInt(2, i + 1);
				stmt->setInt(3, cart[i].product_id);
				stmt->setInt(4, cart[i].quantity);
				stmt->setDouble(5, cart[i].price);

				stmt->executeUpdate();
				conn->commit();
			}
			cout << "The order is successfully completed." << endl;
		}
		catch (SQLException& sqlExcp) {
			cout << sqlExcp.getErrorCode() << ": " << sqlExcp.getMessage();
		}
		conn->terminateStatement(stmt);
	}
	return 1;
}

