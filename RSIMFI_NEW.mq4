//+------------------------------------------------------------------+
//|                                                       RSIMFI.mq4 |
//|                                           Copyright 2020, mertz. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, mertz."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
 


int a[3][6] = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}};
string symbols[3] = {"XAUUSD","GBPUSD","EURUSD"};
int time[6] = {1,5,15,30,60,240};
string timeStr[6] = {"M1", "M5", "M15", "M30", "H1", "H4"}; 
int OnInit()
  {
//---
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+

//OrderSend(symbols[i],OP_SELL,0.01,Bid,0,Ask+600*Point,Ask-200*Point);}

void OnTick()
  {
// --- initialzing

double rsi,mfi;
int i =0;
int j=0;

//SendNotification("Hello, from My EA");
for(i=0;i<3;i++){
   for(j=0;j<6;j++){
       rsi = iRSI(symbols[i],time[j],26,PRICE_CLOSE,0);
       mfi = iMFI(symbols[i],time[j],14,0);
       if((rsi>=68) && (mfi>=75)) {
           if (a[i][j]==0 || a[i][j]==2){
             Alert("SELL"," : "+symbols[i]+" timeframe: "+timeStr[j]);
             a[i][j]=1;
             SendNotification("SELL: "+ symbols[i]+" timeframe: "+timeStr[j]);           
         }}
         
       if((rsi<=32) && (mfi<=25)) {
           if (a[i][j]==0 || a[i][j]==1){ 
            Alert("BUY"," : "+symbols[i]+" timeframe: "+timeStr[j]);
            a[i][j]=2;
            SendNotification("BUY : " +symbols[i]+" timeframe: "+timeStr[j]);
             }
         }
         
        if((rsi>=40) && (mfi>=30) && (a[i][j]==2)) {
            a[i][j]=0;
         }
      
        if((rsi<=60) && (mfi<=70) && (a[i][j]==1)) {
            a[i][j]=0;
         }
   }}
  
  }
//+------------------------------------------------------------------+
