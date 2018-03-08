//+------------------------------------------------------------------+
//|                                                DistributedSR.mq4 |
//|                                    Copyright 2017, Erwin Beckers |
//|                                      https://www.erwinbeckers.nl |
// Donations are welcome !
//
// Like what you see ? Feel free to donate to support further developments..
// 
// BTC: 1J4npABsiQa2GkJu5q6RsjtCR1jxNvZdtu
// BCC: 1J4npABsiQa2GkJu5q6RsjtCR1jxNvZdtu
// LTC: LN4BCwQEUzULg3z6NpA5KQSvUftv3xG9xA
// ETH: 0xfa77e81d94b39b49f4b3dc7880c68ad57e6e7163
// NEO: ANQxQxFd4z5c7P3W1azK7zxvzRNY4dwbJg
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Erwin Beckers"
#property link      "https://www.erwinbeckers.nl"
#property version   "1.00"
#property strict
#property indicator_chart_window


#include <CDistributedSR.mqh>

CDistributedSR* _distributedSR;
//----------------------------------------------------------------------
void init()
{
   _distributedSR = new CDistributedSR(Symbol());
}

//----------------------------------------------------------------------
void deinit()
{
   delete _distributedSR;
}

//----------------------------------------------------------------------
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   _distributedSR.Refresh();
   return(rates_total);
} 
