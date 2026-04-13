using DAL;
using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading.Tasks;

namespace BL
{
    public class HomeworkService : IHomeworkService
    {
      private readonly IHomeworkRepository _repository;

      public HomeworkService(IHomeworkRepository repository)
      {
        _repository = repository;
      }

      public async Task SubmitHomeworkAsync(HomeworkDto homework)
      {
        // כאן אפשר להוסיף לוגיקה נוספת אם רוצים
        await _repository.SaveHomeworkAsync(homework);
      }
    }
  }
