/*
 * main.cpp
 *
 *  Created on: May 16, 2013
 *      Author: xieliang
 */

#include <iostream>
#include "embeddedgmetric.h"


using namespace std;
using namespace allyes;
using namespace allyes::gmetric;


int main(int argc, char* argv[]) {

    const char* ADDR = "localhost";
    const int PORT = 8648;

    cout << "remote addr & port: " << ADDR << ":" << PORT << endl;


    gmetric_t g;
    gmetric_create(&g);
    if (gmetric_open(&g, ADDR, PORT) == 1) {
        cout << "Open succeed." << endl;
    }
    else {
        cout << "Open failed!" << endl;
        return 1;
    }

    /* generate the message and send */
    gmetric_message_t msg;
    gmetric_message_clear(&msg);
    msg.type = GMETRIC_VALUE_INT;
    msg.name = "my-weight";
    msg.value.v_int = 65;
    msg.units = "kg";
    msg.slope = GMETRIC_SLOPE_BOTH;
    msg.tmax = 60;
    msg.dmax = 0;
    if (gmetric_send(&g, &msg) == -1) {
        cout << "Failed to send metric!" << endl;
        return 1;
    }
    else {
        cout << "Succeed to send metric." << endl;
    }

    /* cleanup */
    gmetric_close(&g);
    cout << "End now." << endl;

    return 0;
}

