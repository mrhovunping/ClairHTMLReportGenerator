using System;
using System.Diagnostics.CodeAnalysis;
using NUnit.Framework;

namespace ClairHTMLReportGenerator.test
{
    public class ConverterAdaptedTests
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        [Category("UnitTest")]
        public void GenerateHtml_Not_XML_data()
        {
            var data = "toto";

            var ca = new ConverterAdapted();
            Assert.Throws<System.Xml.XmlException>(() =>
            {
                ca.GenerateHtmlReport(data, "./GenerateHtml_Not_XML_data.html");
            });
        }

        [Test]
        [Category("UnitTest")]
        public void GenerateHtml_XML_data()
        {
            var data = "<toto>titi</toto>";

            var ca = new ConverterAdapted();
            Assert.DoesNotThrow(() =>
            {
                ca.GenerateHtmlReport(data, "./GenerateHtml_Not_XML_data.html");
            });
        }
    }
}