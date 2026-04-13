using DTO;
using Microsoft.EntityFrameworkCore;

namespace DAL
{
  public class UserRepository : IUserRepository
  {
    private readonly AppDbContext _context;

    public UserRepository(AppDbContext context)
    {
      _context = context;
    }

    public async Task<List<User>> GetAllAsync()
    {
      return await _context.Users.ToListAsync();
    }

    public async Task<User> AddAsync(User user)
    {
      _context.Users.Add(user);
      await _context.SaveChangesAsync();
      return user;
    }
  }
}
