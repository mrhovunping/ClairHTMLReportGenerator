using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using System.Xml;
using System.Xml.Serialization;

namespace ClairHTMLReportGenerator
{
    public class ConverterAdapter : IConverter
    {


        public ConverterAdapted Adapted { get; init; }

        /// <summary>
        /// This function generate an Html page from json input
        /// </summary>
        /// <param name="json">json code</param>
        /// /// <param name="output">output path</param>
        /// <returns></returns>
        public bool GenerateHtmlReport(string jsonString, string output)
        {

            ScanReport reportObject;
            try
            {
                reportObject = JsonSerializer.Deserialize<ScanReport>(jsonString);
            }
            catch (Exception ex)
            {
                Console.WriteLine("The input string is not a json data");
                return false;
            }

            var sw = new StringWriter();
            XmlTextWriter tw = null;
            try
            {
                if (reportObject != null)
                {
                    var serializer = new XmlSerializer(reportObject.GetType());
                    tw = new XmlTextWriter(sw);
                    serializer.Serialize(tw, reportObject);
#if DEBUG
                    try
                    {
                        using var xmlWriter = new StreamWriter("./temp.xml", false);
                        xmlWriter.Write(sw);
                        xmlWriter.Flush();
                    }
                    catch (Exception e)
                    {
                        Console.WriteLine(e);
                        throw;
                    }
#endif
                }
                else
                {
                    throw new NullReferenceException("JSON data is empty");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
            finally
            {
                sw.Close();
                tw?.Close();
            }

            try
            {
                Adapted.GenerateHtmlReport(sw.ToString(), output);
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                return false;
            }
        }

    }
}
