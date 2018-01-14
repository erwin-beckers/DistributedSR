//+------------------------------------------------------------------+
//|                                                DistributedSR.mq4 |
//|                                    Copyright 2017, Erwin Beckers |
//|                                      https://www.erwinbeckers.nl |
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
