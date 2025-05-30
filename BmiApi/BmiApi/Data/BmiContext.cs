// Data/BmiContext.cs
using Microsoft.EntityFrameworkCore;
using BmiApi.Models;

namespace BmiApi.Data
{
    public class BmiContext : DbContext
    {
        public BmiContext(DbContextOptions<BmiContext> options) : base(options) { }

        public DbSet<BMIRecord> BMIRecords { get; set; }
        public DbSet<User> User { get; set; }
    }
}
