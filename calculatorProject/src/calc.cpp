#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstdlib>
#include <iomanip>
#include "operations.h"

using namespace std;

const string HISTORY_FILE = "calc_history.txt";
const string ANS_FILE = "ans.txt";

double getPreviousAns() {
    ifstream ansFile(ANS_FILE);
    double ans = 0;
    if (ansFile) {
        ansFile >> ans;
    }
    return ans;
}

void saveAns(double ans) {
    ofstream ansFile(ANS_FILE);
    ansFile << fixed << setprecision(2) << ans;
}

void saveHistory(const string& entry) {
    ofstream historyFile(HISTORY_FILE, ios::app);
    historyFile << entry << endl;
}

void showHistory() {
    ifstream historyFile(HISTORY_FILE);
    if (!historyFile) {
        cout << "No history available." << endl;
        return;
    }
    string line;
    while (getline(historyFile, line)) {
        cout << line << endl;
    }
}

int main() {
    string input;
    double num1, num2, ans = getPreviousAns();
    string op;

    while (true) {
        cout << ">> ";
        getline(cin, input);

        if (input == "EXIT") {
            break;
        }

        if (input == "HIST") {
            showHistory();
            continue;
        }

        istringstream iss(input);
        string token1, token2, token3;
        iss >> token1 >> token2 >> token3;

        if (token1 == "ANS") num1 = ans;
        else num1 = stod(token1);

        op = token2;

        if (token3 == "ANS") num2 = ans;
        else num2 = stod(token3);

        if (op == "+") ans = add(num1, num2);
        else if (op == "-") ans = subtract(num1, num2);
        else if (op == "*") ans = multiply(num1, num2);
        else if (op == "/") {
            if (num2 == 0) {
                cout << "MATH ERROR" << endl;
                continue;
            }
            ans = divide(num1, num2);
        }
        else {
            cout << "SYNTAX ERROR" << endl;
            continue;
        }

        saveAns(ans);
        saveHistory(input + " = " + to_string(ans));
        cout << fixed << setprecision(2) << ans << endl;
    }
    return 0;
}

