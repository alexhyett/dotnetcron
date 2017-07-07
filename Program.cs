using System;

namespace test_dotnet
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine($"This program should be running on a schedule: {DateTime.Now}");
            Console.WriteLine($"TEST_ENV={Environment.GetEnvironmentVariable("TEST_ENV")}");
        }
    }
}
