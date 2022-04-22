using System.Collections.Generic;

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
