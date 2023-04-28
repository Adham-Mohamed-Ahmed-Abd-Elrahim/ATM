#pragma once
using namespace std;
#include <iostream>
#include <string>
#include<fstream>
#include <bits/stdc++.h>
#include <sstream>
#include<windows.h>
namespace STATE_MACHINE
{ typedef enum States
    {
        IDLE,
        CHECK_CARD,
        LANGUAGE_CHOICE,
        OPERATION_CHOICE,
        DEPOSITE,
        WITHDRAWAL,
        TRANSFER,
        BALANCE_SERVICE,
        ABORT
    }states_m;

      typedef enum operation
    {   OP_DEPOSITE,
        OP_WITHDRAWAL,
        OP_BALANCE_SERVICE,
        OP_TRANSFER,
        CANCEL
    }operation_m;

   typedef enum language
    {   ARABIC,
        ENGLISH
    }language_m;

    class ATM
	{
	private:
states_m current_state,next_state;
operation_m op_choice;
language_m language_choice_m;
ifstream card_check_file;
ifstream credit_file;
   string * ref_password;
   string * valid_bit;
   string * up_limit;
   string * available_credit;
   int number_of_users;
int atm_capacity;
int pin_card;
int pin_card_transfer;
	public:
		~ATM();
		ATM();
		void set_state();
        void set_operation();
        void check_card();
		void language_choice();
        void deposite();
        void withdrawal();
        void balance_service();
        void transfer();
        void abort();

		//
	};



}
