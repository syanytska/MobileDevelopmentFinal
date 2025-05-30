using Microsoft.AspNetCore.Mvc;
using BmiApi.Data;
using BmiApi.Models;
using Microsoft.EntityFrameworkCore;

namespace BmiApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class BMIRecordsController : ControllerBase
    {
        private readonly BmiContext _context;

        public BMIRecordsController(BmiContext context)
        {
            _context = context;
        }

        // GET: api/BMIRecords
        [HttpGet("GetRecords")]
        public async Task<ActionResult<IEnumerable<BMIRecord>>> GetRecords()
        {
            return await _context.BMIRecords.ToListAsync();
        }

        // POST: api/BMIRecords
        [HttpPost("PostRecords")]
        public async Task<ActionResult<BMIRecord>> PostRecord(BMIRecord record)
        {
            User? userToPost = await _context.User.FirstOrDefaultAsync(u => u.UserId == record.UserId);
            if(userToPost == null)
            {
                return BadRequest("User not found.");
            }   

            record.UserId = userToPost.UserId;

            // Calculate BMI
            if (record.HeightCm > 0)
            {
                double heightM = record.HeightCm / 100.0;
                record.Bmi = record.WeightKg / (heightM * heightM);
            }

            _context.BMIRecords.Add(record);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetRecords), new { id = record.BMIRecordId }, record);
        }

    }
}

