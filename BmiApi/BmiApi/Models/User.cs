namespace BmiApi.Models
{
    public class User
    {
        public long UserId { get; set; }
        public string? Username { get; set; }
        public string? Email { get; set; }
        public string? PasswordHash { get; set; }
        public long? RoleId { get; set; } // 0 for user, 1 for admin

    }
}

