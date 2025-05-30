// Models/BMIRecord.cs
using System;

namespace BmiApi.Models
{
    public class BMIRecord
    {
        public long BMIRecordId { get; set; }
        public string? Username { get; set; }
        public double HeightCm { get; set; }
        public double WeightKg { get; set; }
        public double? Bmi { get; set; }
        public long UserId { get; set; }
        public User? User { get; set; }
        public DateTime? DateCreated { get; set; } = DateTime.Now;
    }
} 
