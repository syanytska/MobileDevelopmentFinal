using Microsoft.AspNetCore.Mvc;
using BmiApi.Models;
using BmiApi.Data;

namespace FlutterUserApi.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly BmiContext _context;

        public UserController(BmiContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult GetUser()
        {
            return Ok(_context.User.ToList());
        }

        [HttpPost]
        public IActionResult AddUser([FromBody] User user) // ✅ Now binds JSON from Flutter
        {
            if (user == null || string.IsNullOrWhiteSpace(user.Username))
                return BadRequest("Invalid user");

            _context.User.Add(user);
            _context.SaveChanges();
            return Ok(user);
        }


        [HttpPut("{id}")]
        public IActionResult UpdateUser(int id, User user)
        {
            var existing = _context.User.Find(id);
            if (existing == null) return NotFound();

            existing.Username = user.Username;
            existing.Email = user.Email;

            _context.SaveChanges();
            return Ok(existing);
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUser(int id)
        {
            var user = _context.User.Find(id);
            if (user == null) return NotFound();

            _context.User.Remove(user);
            _context.SaveChanges();
            return Ok();
        }
    }
}
