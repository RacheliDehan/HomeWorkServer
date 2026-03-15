using DTO;

namespace DAL
{
  public interface IUserRepository
  {
    Task<List<User>> GetAllAsync();
    Task<User> AddAsync(User user);
  }
}
