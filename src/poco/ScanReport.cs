using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClairHTMLReportGenerator
{
    public class ScanReport
    {        
        // ReSharper disable once InconsistentNaming
        public string image { get; set; }
        // ReSharper disable once InconsistentNaming
        public List<string> unapproved { get; set; }
        // ReSharper disable once InconsistentNaming
        public List<Vulnerability> vulnerabilities { get; set; }
    }
}
