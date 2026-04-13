using DTO;

namespace BL
{
  public interface IUserService
  {
    Task<List<User>> GetAllUsers();
    Task<User> CreateUser(User user);
  }
}
