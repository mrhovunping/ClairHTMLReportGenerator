using System;
using System.IO;
using System.Xml;
using System.Xml.Xsl;

namespace ClairHTMLReportGenerator
{
    public class ConverterAdapted
    {

        /// <summary>
        /// Generate HTML from xml input
        /// </summary>
        /// <param name="xml">xml document</param>
        /// <param name="outputPath">output path location</param>
        /// <returns></returns>
        public void GenerateHtmlReport(string xml, string outputPath)
        {
            var results = new StringWriter();
            try
            {
                var transform = new XslCompiledTransform();
                //This will give us the full name path of the executable file:
                //i.e. C:\Program Files\MyApplication\MyApplication.exe
                var strExeFilePath = System.Reflection.Assembly.GetExecutingAssembly().Location;
                //This will strip just the working path name:
                //C:\Program Files\MyApplication
                var strWorkPath = System.IO.Path.GetDirectoryName(strExeFilePath);
                transform.Load(Path.Combine(strWorkPath, "resources","clairReportTranformation.xslt"));
                using var reader = XmlReader.Create(new StringReader(xml));
                transform.Transform(reader, null, results);

            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
            
            try
            {
                using var sw = new StreamWriter(outputPath, false);
                sw.Write(results);
                sw.Flush();
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

    }
}
