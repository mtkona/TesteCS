using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TesteC
{
    public class Trade:ITrade
    {
        public double Value { get; set; }
        public string ClientSector { get; set; }

        public List<string> GetCategories(List<Trade> portfolio) 
        {
            List<string> result = new List<string>();
            foreach(Trade trade in portfolio)
            {
                if (trade.ClientSector == "Public" && trade.Value<1000000)
                {
                    result.Add("LOWRISK");
                }
                if (trade.ClientSector == "Public" && trade.Value > 1000000)
                {
                    result.Add("MEDIUMRISK");
                }
                if (trade.ClientSector == "Private" && trade.Value > 1000000)
                {
                    result.Add("HIGHRISK");
                }


            }

            return result;

        }
    }
}
