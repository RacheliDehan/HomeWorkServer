using DTO;
using DAL;

namespace BL
{
  public class UserService : IUserService
  {
    private readonly IUserRepository _userRepository;

    public UserService(IUserRepository userRepository)
    {
      _userRepository = userRepository;
    }

    public async Task<List<User>> GetAllUsers()
    {
      return await _userRepository.GetAllAsync();
    }

    public async Task<User> CreateUser(User user)
    {
      return await _userRepository.AddAsync(user);
    }
  }
}
