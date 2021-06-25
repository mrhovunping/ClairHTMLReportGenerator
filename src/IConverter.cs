using System;
using System.Collections.Generic;
using System.Runtime.Serialization.Json;
using System.Text;

namespace ClairHTMLReportGenerator
{
    /// <summary>
    /// This interface is used to implement a generate HTML document
    /// </summary>
    public interface IConverter
    {
        /// <summary>
        /// This function creates a HTML document from JSON file    
        /// </summary>
        /// <param name="json"></param>
        /// <param name="outputPath"></param>
        /// <returns>Path to the HTML file created</returns>
        public bool GenerateHtmlReport(string json, string outputPath);
    }
}
