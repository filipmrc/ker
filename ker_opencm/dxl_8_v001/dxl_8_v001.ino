/*  Dynamixel SyncWrite
 
 This example shows same movement as previous syncwrite
 
                 Compatibility
 CM900                  O
 OpenCM9.04             O
 
                  Dynamixel Compatibility
               AX    MX      RX    XL-320    Pro
 CM900          O      O      O        O      X
 OpenCM9.04     O      O      O        O      X
 **** OpenCM 485 EXP board is needed to use 4 pin Dynamixel and Pro Series ****  
 
 created 16 Nov 2012
 by ROBOTIS CO,.LTD.
 */
/* Dynamixel ID defines */
#define ID_NUM_1  1
#define ID_NUM_2  2
#define ID_NUM_3  3
#define ID_NUM_4  4
#define ID_NUM_5  5
#define ID_NUM_6  6
#define ID_NUM_7  7
#define ID_NUM_8  8

/* Control table defines */
#define P_GOAL_POSITION    30
#define P_GOAL_SPEED    32
#define PRESENT_POS 54
#define P_Gain 29
#define I_Gain 28
#define D_Gain 27

/********* Sync write data  **************
 * ID1, DATA1, DATA2..., ID2, DATA1, DATA2,...
 ******************************************
 */
 /* Serial device defines for dxl bus */
#define DXL_BUS_SERIAL1 1  //Dynamixel on Serial1(USART1)  <-OpenCM9.04
#define DXL_BUS_SERIAL2 2  //Dynamixel on Serial2(USART2)  <-LN101,BT210
#define DXL_BUS_SERIAL3 3  //Dynamixel on Serial3(USART3)  <-OpenCM 485EXP

Dynamixel Dxl(DXL_BUS_SERIAL1);

int pos, i = 0, j = 0;
int pos_goal = 0, vel_goal = 0;
char poruka[]="";
char send_data[] = "";
word motor[12];
int button = 0;
//word SyncPage1[24]=
//{ 
//  ID_NUM_1,0,300,  // 3 Dynamixels are move to position 0
//  ID_NUM_2,0,300,  // with velocity 100
//  ID_NUM_3,0,300,
//  ID_NUM_4,0,300,
//  ID_NUM_5,0,300,  // 3 Dynamixels are move to position 0
//  ID_NUM_6,0,300,  // with velocity 100
//  ID_NUM_7,0,300,
//  ID_NUM_8,0,300}; 


void setup(){
// Dynamixel 2.0 Protocol -> 0: 9600, 1: 57600, 2: 115200, 3: 1Mbps 
  Dxl.begin(3);
  //Set all dynamixels as same condition.
  Dxl.writeWord( BROADCAST_ID, P_GOAL_POSITION, 511 );
  delay(200);
  Dxl.writeWord( BROADCAST_ID, P_GOAL_SPEED, 200 );
  for (j = 0; j < 12; j++){
    if(j == 0 || j == 3 || j == 6 || j == 9){
      Dxl.writeByte( j+1, P_Gain, 64);
      Dxl.writeByte( j+1, D_Gain, 8);
    }
    Dxl.writeByte( j+1, P_Gain, 64 );
    Dxl.writeByte( j+1, D_Gain, 8);
  }
//  Dxl.writeByte( BROADCAST_ID, P_Gain, 64 );
//  Dxl.writeByte( BROADCAST_ID, D_Gain, 32 );
  Dxl.ledOn(BROADCAST_ID, 3);
  pinMode(BOARD_BUTTON_PIN, INPUT_PULLDOWN);
  pinMode(BOARD_LED_PIN, OUTPUT);
  
}

void loop(){
  
  
//  for(j = 0; j < 8; j++){
//    SerialUSB.write("<");
//    char buffer[5];
//    pos = Dxl.readWord(j+1, PRESENT_POS);
//    itoa((1000*(j+1)+pos), buffer, 10);
//    SerialUSB.write(buffer);
//    SerialUSB.write(">");
//  }
  if (digitalRead(BOARD_BUTTON_PIN)){
    button = 1;
  }
  for(j = 0; j < 12; j++){
    pos = Dxl.readWord(j+1, PRESENT_POS);
    if (j == 1 || j == 4 || j == 6 || j == 8 || j == 11){
      itoa(1022 - (pos), &send_data[j*3], 10);
    }
    else if (j == 9)
      itoa(1022 - (pos), &send_data[j*3], 10);
    else{
      itoa((pos), &send_data[j*3], 10);
    }
  }
  SerialUSB.write(send_data);
  SerialUSB.write('\r\n');
  char send_data[] = "";
  while (SerialUSB.available() > 0){
    poruka[i] = word(SerialUSB.read());   
    i++; 
  } 
  if ( i > 0 && button){
    
    for(j = 0; j < 12; j++){
      motor[j] = word(poruka[j*3]-'0')*100 + word(poruka[j*3+1]-'0')*10 + word(poruka[j*3+2]-'0');
    }
    motor[1] = 1022 - motor[1];
    motor[4] = 1022 - motor[4];
    motor[6] = 1022 - motor[6];
    motor[8] = 1022 - motor[8];
    motor[9] = 1022 - motor[9] - 5;
    motor[11] = 1022 - motor[11];
    for( j = 11; j >= 0; j--){
      if (motor[j] == 0){
        motor[j] = 512;
      }
      Dxl.writeWord(j+1, P_GOAL_POSITION, motor[j]);
    }
    
//    SyncPage1[1] = word(atoi(&motor1[0]));
//    SyncPage1[4] = word(atoi(&motor2[0]));
//    SyncPage1[7] = word(atoi(&motor3[0]));
//    SyncPage1[10] = word(atoi(&motor4[0]));
//    SyncPage1[13] = word(atoi(&motor5[0]));
//    SyncPage1[16] = word(atoi(&motor6[0]));
//    SyncPage1[19] = word(atoi(&motor7[0]));
//    SyncPage1[22] = word(atoi(&motor8[0]));
//    Dxl.syncWrite(30,2,SyncPage1,24);
    char poruka[] = "";
    i = 0;
  }
  //SerialUSB.print("Freq: ");
  //SerialUSB.println(float(1000000/(stop-start))); 
}




