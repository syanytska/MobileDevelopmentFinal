using Microsoft.AspNetCore.Mvc;
using BmiApi.Data;
using BmiApi.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace BmiApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly BmiContext _context;
        private readonly IConfiguration _config;

        public AuthController(BmiContext context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }


        [HttpPost("register")]
        public IActionResult Register([FromBody] User user)
        {
            if (string.IsNullOrEmpty(user.Username) || string.IsNullOrEmpty(user.PasswordHash))
                return BadRequest("Email and password are required.");

            if (_context.User.Any(u => u.Username == user.Username))
                return BadRequest("User already exists.");

            var hashed = BCrypt.Net.BCrypt.HashPassword(user.PasswordHash);
            user.PasswordHash = hashed;

            _context.User.Add(user);
            _context.SaveChanges();
            return Ok("User registered successfully.");
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] User loginData)
        {
            if (string.IsNullOrEmpty(loginData.Username) || string.IsNullOrEmpty(loginData.PasswordHash))
                return BadRequest("Username and password are required.");

            var user = _context.User.FirstOrDefault(u => u.Username == loginData.Username);

            if (user == null || loginData.PasswordHash == null || !BCrypt.Net.BCrypt.Verify(loginData.PasswordHash, user.PasswordHash))
                return Unauthorized("Invalid email or password.");

            var key = Encoding.UTF8.GetBytes(_config["JwtKey"] ?? "this is a secsadfh;adfhlkasdhfluashdfl;iuhfasduasdfukret key for jwt");

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] {
                    new Claim(ClaimTypes.NameIdentifier, user.UserId.ToString()),
                    new Claim(ClaimTypes.Name, user.Username) //  Username instead of email
            }),

                Expires = DateTime.UtcNow.AddHours(1),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature
                )
            };

            try
            {
                var tokenHandler = new JwtSecurityTokenHandler();

                var token = tokenHandler.CreateToken(tokenDescriptor);

                return Ok(new
                {
                    token = tokenHandler.WriteToken(token),
                    userId = user.UserId,
                    username = user.Username,
                    role = user.RoleId
                });

            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            return BadRequest();

        }
    }
}
