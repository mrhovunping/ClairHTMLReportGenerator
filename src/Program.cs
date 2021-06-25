using System;
using System.CommandLine;
using System.CommandLine.Invocation;
using System.IO;

namespace ClairHTMLReportGenerator
{
    public class Program
    {

        public static int Main(string[] args)
        {
            // Create a root command with some options
            var rootCommand = new RootCommand
            {
                new Option<string>("--input",
                    "Path to the input JSON file."), 
                new Option<string>("--output",
                    getDefaultValue: () =>"./ClairScanAnalysisReport.html",
                    description: "Path to the output JSON file.")
            };


            rootCommand.Description = "Application to convert ClairScan JSON output to HTML.";

            // Note that the parameters of the handler method are matched according to the names of the options
            rootCommand.Handler = CommandHandler.Create<string, string>(Convert);

            return rootCommand.InvokeAsync(args).Result;
        }

        public static void Convert(string input, string output)
        {
            Console.WriteLine($"The value for --input is: {input}");
            Console.WriteLine($"The value for --output is: {output}");

            var adapted = new ConverterAdapted();
            IConverter target = new ConverterAdapter
                { Adapted = adapted};
            target.GenerateHtmlReport(File.ReadAllText(input), output);

            Console.WriteLine($"JSON file successfully converted: {output}");

        }
    }
}
