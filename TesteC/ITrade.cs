﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TesteC
{
    public interface ITrade
    {
        public double Value { get; set; }
        public string ClientSector { get; set; }
        public List<string> GetCategories(List<Trade> portfolio);
    }
}
