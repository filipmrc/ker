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
char poruka[]="" , motor1[5],motor2[5],motor3[5],motor4[5],motor5[5],motor6[5];
char send_data[] = "", mot7[5],moto8[5];
unsigned int stop = 0, start = 0;
word motor[8];

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
  Dxl.writeWord( BROADCAST_ID, P_GOAL_POSITION, 0 );
  Dxl.writeWord( BROADCAST_ID, P_GOAL_SPEED, 500 );
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
  start = micros();
  for(j = 0; j < 8; j++){
    pos = Dxl.readWord(j+1, PRESENT_POS);
    itoa((1000*(j+1)+pos), &send_data[j*4], 10);
  }
  SerialUSB.write(send_data);
  SerialUSB.write('\r\n');
  char send_data[] = "";
  while (SerialUSB.available() > 0){
    poruka[i] = word(SerialUSB.read());   
    i++; 
  } 
  if ( i > 0 ){
    for(j = 0; j < 4; j++){
      motor1[j] = poruka[j];
      motor2[j] = poruka[j+4];
      motor3[j] = poruka[j+8];
      motor4[j] = poruka[j+12];
      motor5[j] = poruka[j+16];
      motor6[j] = poruka[j+20];
      mot7[j] = poruka[j+24];
      moto8[j] = poruka[j+28];
    }
    
    word motor[8] = {word(atoi(&motor1[0])), word(atoi(&motor2[0])), word(atoi(&motor3[0])), word(atoi(&motor4[0])), word(atoi(&motor5[0])), word(atoi(&motor6[0])), word(atoi(&mot7[0])), word(atoi(&moto8[0]))};

    for( j = 0; j < 8; j++){
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
  stop = micros();
  //SerialUSB.print("Freq: ");
  //SerialUSB.println(float(1000000/(stop-start))); 
}




