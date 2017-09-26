using System;
using System.IO;
using Microsoft.Extensions.Configuration;

namespace DotNetCron
{
    class Program
    {
        static void Main(string[] args)
        {
            var configuration = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional:true, reloadOnChange:true)  
                //.AddEnvironmentVariables(prefix: "CRON_")           
                .Build();

            var consoleSettings = new ConsoleSettings();
            configuration.GetSection("Console").Bind(consoleSettings);

            Console.WriteLine($"{DateTime.UtcNow}: Output String: '{consoleSettings.OutputString}'");
        }
    }
}
