using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading.Tasks;

namespace DAL
{

  
    public interface IHomeworkRepository
    {
      Task SaveHomeworkAsync(HomeworkDto homework);
    }
  }
