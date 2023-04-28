#include "ATM.h"

using namespace std;
namespace STATE_MACHINE
{  /////////////////////////////////////////////////////////////////////////////
using namespace std;
#include <string>
#include<dos.h>
        /////////////////////////////// destructor ////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////
	ATM::~ATM()
	{
		cout << "Destroyed" << endl;

	}
	    /////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// Constructor ////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////
	ATM::ATM()
	{ int atm_capacity_in;
		cout << "Welcome " << endl;
		this->current_state = IDLE;
		this->next_state = IDLE;
      cout<<"Enter ATM_Capacity"<<endl;
      cin>>atm_capacity_in;
        this->atm_capacity = atm_capacity_in;
       this->atm_capacity = atm_capacity_in;
        ////////////////////////// File handling /////////////////////////////////
                 //############################## Credit file ###################################
card_check_file.open("check_card.txt");
credit_file.open("credit_file.txt");


            if (card_check_file.fail())//Checking if opening that file 's been successful
            { cerr << "error loading card_check_file ..." << endl;
            }
            else
            {
   string line;
   int count = 0;
   while (getline(card_check_file, line)) {
      count++;
   }

   card_check_file.clear();
   card_check_file.seekg(0, ios::beg);

   string* lines = new string[count];
   this->up_limit= new string[count];
   this->available_credit=new string[count];
   int i = 0;
   while (getline(card_check_file, line)) {
      lines[i] = line;
    this->up_limit[i]=lines[i].substr(0, 5);
      this->available_credit[i]=lines[i].substr(6, 13);
      // cout<<up_limit[i]<<" "<<available_credit[i]<<endl;

     // cout<<lines[i]<<endl;
      i++;
            }
            }
            //############################## Credit file ###################################
             if (credit_file.fail())//Checking if opening that file 's been successful
            {
                cerr << "error loading credit_file .." << endl;
            }
            else
            {
  string line;
   int count = 0;
   while (getline(credit_file, line)) {
      count++;
   }
    this->number_of_users=count;
   credit_file.clear();
   credit_file.seekg(0, ios::beg);

   string* lines = new string[count];
   this->ref_password= new string[count];
   this->valid_bit=new string[count];

   int i = 0;
   while (getline(credit_file, line)) {
      lines[i] = line;
      this->ref_password[i]=lines[i].substr(0, 4);
      this->valid_bit[i]=lines[i].substr(5, 6);
       //cout<<ref_password[i]<<" "<<valid_bit[i]<<endl;

      i++;
            }


}
system("CLS");
  set_state();
	}
	          /////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// Set_State ////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////
   void  ATM::set_state()
    { int insert_card;
        while(1)
        {this->current_state=this->next_state;
            switch(this->current_state)
        {
        case IDLE:
             system("CLS");
            cout << "Welcome Insert Card :" << endl;
            cin>>insert_card;

            if(insert_card==1){this->next_state=CHECK_CARD;}
        break;

         case CHECK_CARD:
                       system("CLS"); ATM::check_card();
        break;

         case LANGUAGE_CHOICE:
              system("CLS");   ATM::language_choice();
            break;

         case OPERATION_CHOICE:
             system("CLS");           ATM::set_operation();
            break;

         case DEPOSITE:
               system("CLS");         ATM::deposite();
            break;
        case WITHDRAWAL:
               system("CLS");          ATM::withdrawal();
            break;
        case BALANCE_SERVICE:
               system("CLS");         ATM::balance_service();
            break;

        case TRANSFER:
               system("CLS");          ATM::transfer();
            break;

        case ABORT:
               system("CLS");         ATM::abort();
            break;

        default:cout << "wrong input" << endl; break;

        }
        }

    }
        /////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// Check_Card ////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////
void ATM::check_card()
{
    //static int trials =0;
string input_password;
this->pin_card =  (rand() % 64);
cout<<"Pin_Card="<<pin_card<<endl;

cout<<"Enter Password :"<<endl;
cin>>input_password;
cin.ignore();
cout<<input_password;
cout<<ref_password[pin_card-1];
//if(ref_password[pin_card].compare(input_password) == 0)
if(ref_password[pin_card-1]==input_password)
{
//if(valid_bit[pin_card]=="1")
cout<<input_password<<"true"<<endl;
this->next_state=LANGUAGE_CHOICE;
return;
//}
}
else
{/*trials++;
if(trials==3)
{cout<<"Too many trials , spelling out Card "<<endl;*/
this->next_state=ABORT;
return;
}
}

/////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// language_choice ////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////
void ATM::language_choice()
{int lang_choice;
cout<<"Enter Language:"<<endl;
cout<<"1)Arabic."<<endl;
cout<<"2)English."<<endl;
cin>>lang_choice;
cin.ignore();
bool done=0;
while (done!=1)
{
switch(lang_choice)
{case 1:this->language_choice_m=ARABIC;
done=1;
    break;
case 2:this->language_choice_m=ENGLISH;
done=1;
    break;
    default: cout<<"Wrong Choice"<<endl;
    Sleep(500);
     break;
}
}
this->next_state=OPERATION_CHOICE;

return;
}

    /////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// set_operation ////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////
 void   ATM::set_operation()
 {      int  m_choice;
        cout<<"choose operation:"<<endl;
        cout << "1_Deposite" << endl;
        cout << "2_Withdrawal" << endl;
        cout << "3-Balance Service" << endl;
        cout << "4-Transfer" << endl;
        cout << "5-Cancel" << endl;
        cin>>m_choice;
        //cin.ignore();
        switch (m_choice)
        {
        case 1 /*OP_DEPOSITE*/:
                        this->next_state = DEPOSITE;
            break;
        case 2 /*OP_WITHDRAWAL*/:
                        this->next_state = WITHDRAWAL;
            break;
        case 3 /*OP_BALANCE_SERVICE*/:
                        this->next_state = BALANCE_SERVICE;
            break;

        case 4 /*OP_TRANSFER*/:
                        this->next_state = TRANSFER;
            break;

        case 5 /*CANCEL*/:
                        this->next_state = IDLE;
            break;

        default:cout << "wrong input" << endl;
        Sleep(500);
        break;
        }

return;
 }


    /////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// Deposite ////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////
   void ATM::deposite()
{int deposite_val;
cout<<"Enter Deposite Value"<<endl;
cin>>deposite_val;
cout<<"Pre available_credit"<<this->available_credit[(this->pin_card)-1]<<endl;
int final_credit;
    std::istringstream text_stream(available_credit[(this->pin_card)-1]);
    text_stream >> final_credit;
  //  cout<<final_credit;
//this->available_credit[(this->pin_card)-1]=atoi((this->available_credit[(this->pin_card)-1]) +deposite_val);
//cout<<"pre available_credit"<<final_credit<<endl;
final_credit+=deposite_val;
//this->available_credit[(this->pin_card)-1]=str(final_credit);
    stringstream ss;
    ss << final_credit;
    string final_credit_cred=ss.str();
this->available_credit[(this->pin_card)-1]=final_credit_cred;
this->atm_capacity+=deposite_val;

cout<<"Post available_credit"<<this->available_credit[(this->pin_card)-1]<<endl;
cout<<"wait...\n"<<endl;
Sleep(2000);
this->next_state=OPERATION_CHOICE;
return;
}

    /////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// withdrawal ////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////
void ATM::withdrawal()
{int withdrawal_value;
cout<<"Enter withdrawal Value"<<endl;
cin>>withdrawal_value;
int available_credit,final_credit,up_limit,final_up_limit;
// for Available credit
    std::istringstream text_stream((this->available_credit[(this->pin_card)-1]));
    text_stream >> available_credit;

    // for up_limit
  //     std::istringstream text_stream((this->up_limit);
     //std::istringstream text_stream((this->up_limit[(this->pin_card)-1]));
     stringstream ss;
     ss<<this->up_limit[(this->pin_card)-1];
    ss >> up_limit;


    cout<<available_credit <<" "<<up_limit<<endl;

    if((withdrawal_value<=available_credit)&&(withdrawal_value<=this->atm_capacity)&&(withdrawal_value<=up_limit))
    {final_credit=available_credit-withdrawal_value;
     final_up_limit=up_limit-withdrawal_value;
     this->next_state=OPERATION_CHOICE;
	cout<<"wait...\n"<<endl;
	Sleep(2000);

	}
    else
        {Sleep(2000);
            this->next_state=ABORT;
        }
        stringstream dd,vv;
    dd << final_credit;
    string final_credit_cred=dd.str();
    vv<<final_up_limit;
    string up_limit_final=vv.str();
this->available_credit[(this->pin_card)-1]=final_credit_cred;
this->up_limit[(this->pin_card)-1]=up_limit_final;
cout<<"Post available_credit"<<this->available_credit[(this->pin_card)-1]<<endl;
cout<<"Post up_limit"<<this->up_limit[(this->pin_card)-1]<<endl;

 Sleep(2000);
return;
}
    /////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// Balance_Service ////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////
void ATM::balance_service()
{
cout<<"Your balance is : "<<endl;
cout<<this->available_credit[(this->pin_card)-1]<<endl;
	Sleep(2000);
this->next_state=OPERATION_CHOICE;
return;
}
    /////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// Transfer ////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////
void ATM::transfer()
{int transfer_val;
cout<<"Enter Transfer Value:"<<endl;
cin>>transfer_val;
cout<<"Enter ID of intended transfer card "<<endl;
cin>>this->pin_card_transfer;
int available_credit,available_credit_transfer,up_limit,final_credit,final_credit_transfer,up_limit_final;
// for Available credit
    std::istringstream text_stream((this->available_credit[(this->pin_card)-1]));
    text_stream >> available_credit;
  stringstream ss,rr;
    ss << this->available_credit[(pin_card_transfer)];
    rr << this->up_limit[(this->pin_card)-1];
    ss >> available_credit_transfer;
    rr>>up_limit;
cout<<"pre_transaction:"<<endl<<"user_credit="<<available_credit<<endl<<"Transfer_user_credit="<<available_credit_transfer<<endl;

    if((transfer_val<=available_credit)&&(transfer_val<=up_limit))
    {final_credit=available_credit-transfer_val;
     up_limit_final=up_limit-transfer_val;
     final_credit_transfer=available_credit_transfer+transfer_val;

     cout<<"post_transaction:"<<endl<<"user_credit="<<final_credit<<endl<<"Transfer_user_credit="<<final_credit_transfer<<endl;
Sleep(10000);
	cout<<"wait...\n"<<endl;
	 this->next_state=OPERATION_CHOICE;
	}

    else
        {Sleep(2000);
            this->next_state=ABORT;
        }
    stringstream dd,vv,zz;
    dd << final_credit;
    string final_credit_cred=dd.str();
    vv<<final_credit_transfer;
    string credit_transfer_final=vv.str();
    zz<<up_limit_final;
     string up_limit_final_s=zz.str();
this->available_credit[(this->pin_card)-1]=final_credit_cred;
this->up_limit[(this->pin_card)-1]=up_limit_final_s;
this->available_credit[pin_card_transfer]=credit_transfer_final;

cout<<"Post available_credit_transfer"<<this->available_credit[pin_card_transfer]<<endl;
cout<<"Post up_limit_transfer"<<this->up_limit[pin_card_transfer]<<endl;
cout<<"Post available_credit_transfer"<<this->available_credit[(this->pin_card)-1]<<endl;
cout<<"Post up_limit_transfer"<<this->up_limit[(this->pin_card)-1]<<endl;

//this->available_credit[(this->pin_card)-1]=str(final_credit);
//this->available_credit[(this->pin_card)-1]=to_string(final_credit);
//cout<<"Post available_credit"<<this->available_credit[(this->pin_card)-1]<<endl;
 Sleep(10000);
return;

}
    /////////////////////////////////////////////////////////////////////////////
    /////////////////////////////// Abort ////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////
    void ATM::abort()
{
  cout<<"Error ..."<<endl<<"Please take your card..."<<endl;
  Sleep(10000);
  this->next_state=IDLE;
}
}
