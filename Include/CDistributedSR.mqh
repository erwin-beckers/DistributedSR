//+------------------------------------------------------------------+
//|                                               CDistributedSR.mqh |
//|                                    Copyright 2017, Erwin Beckers |
//|                                      https://www.erwinbeckers.nl |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Erwin Beckers"
#property link      "https://www.erwinbeckers.nl"
#property strict

#include <CDownloadFile.mqh>

class CDistributedSR
{
private:
   CDownloadFile* _http;
   string         _symbol;
   int            _prevDay;
   double         _srLevels[];
   int            _levelCount;
   
   
   //----------------------------------------------------------------------
   void Clear()
   {
      bool deleted = false;
      do 
      {
         deleted = false;
         for (int i = 0; i < ObjectsTotal();++i)
         {
            string name = ObjectName(0, i);
            if (StringSubstr(name, 0, 1) == "~")
            {
               ObjectDelete(0, name);
               deleted = true;
               break;
            }
         }
      } while (deleted);
   }
   
   //----------------------------------------------------------------------
   void LoadSR()
   {
      _levelCount = 0;
      Clear();
      string key    = _symbol;
      StringToLower(key);
      
      string url    = "https://www.erwinbeckers.nl/sr/" + key + ".txt";
      string httpResult = "";
      
      Print("grab:", url);
      if (!_http.GrabWeb(url, httpResult))
      {
         // maybe there is no network connection ?
         return;
      }
       
      string lines[]; 
      int lineCount = StringSplit(httpResult, 10,lines);
      for (int i=0; i < lineCount;++i)
      {
         string priceTxt = lines[i];
         StringReplace(priceTxt,"\r","");
         StringReplace(priceTxt,"\t","");
         priceTxt = StringTrimLeft(priceTxt);
         priceTxt = StringTrimRight(priceTxt);
         if (StringLen(priceTxt) == 0) continue;
         double price= StringToDouble(priceTxt);
         _srLevels[_levelCount++] = price;
         
      }
   }
   
   //----------------------------------------------------------------------
   void DrawSR()
   {
      for (int i=0; i < _levelCount; ++i)
      {
         string name= "~"+IntegerToString(i);
         ObjectCreate(0, name, OBJ_HLINE, 0, 0, _srLevels[i]);
         ObjectSet(name, OBJPROP_COLOR, clrBlack);
         ObjectSet(name, OBJPROP_WIDTH, 1);
         ObjectSet(name, OBJPROP_BACK, true);
         ObjectSet(name, OBJPROP_STYLE, STYLE_SOLID);
      }
   }
   
public:
   //----------------------------------------------------------------------
   CDistributedSR(string symbol)
   {
      _symbol     = symbol;
      _prevDay    = 0;
      _http       = new CDownloadFile();
      ArrayResize(_srLevels, 5000);
   }
   
   //----------------------------------------------------------------------
   ~CDistributedSR()
   {
      Clear();
      delete _http;
      ArrayFree(_srLevels);
   }
   
   //----------------------------------------------------------------------
   void Refresh()
   {
      int day = TimeDayOfYear(TimeCurrent());
      if (day == _prevDay) return;
      _prevDay = day;
      
      LoadSR();
      DrawSR();
   }
};