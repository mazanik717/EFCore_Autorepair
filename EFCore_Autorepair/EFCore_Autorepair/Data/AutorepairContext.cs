using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using EFCore_Autorepair.Models;

namespace EFCore_Autorepair.Data
{
    public class AutorepairContext : DbContext
    {
        public DbSet<Car> Cars { get; set; }
        public DbSet<Mechanic> Mechanics { get; set; }
        public DbSet<Owner> Owners { get; set; }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<Qualification> Qualifications { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            ConfigurationBuilder builder = new();
            builder.SetBasePath(Directory.GetCurrentDirectory());
            builder.AddJsonFile("appsettings.json");
            IConfigurationRoot config = builder.Build();
            string connectionString = config.GetConnectionString("DefaultConnection");
            _ = optionsBuilder.UseSqlServer(connectionString).Options;
            optionsBuilder.LogTo(message => System.Diagnostics.Debug.WriteLine(message));


        }
    }
}
