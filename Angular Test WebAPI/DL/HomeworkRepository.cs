using DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using System.Text.Json;

namespace DAL
{
    public class HomeworkRepository : IHomeworkRepository
    {
      private readonly string _filePath = "homeworks.json";

      public async Task SaveHomeworkAsync(HomeworkDto homework)
      {
        List<HomeworkDto> homeworks = new List<HomeworkDto>();

        // קרא אם הקובץ קיים
        if (File.Exists(_filePath))
        {
          var existingData = await File.ReadAllTextAsync(_filePath);
          homeworks = JsonSerializer.Deserialize<List<HomeworkDto>>(existingData) ?? new List<HomeworkDto>();
        }

        // הוסף את השיעור החדש
        homeworks.Add(homework);

        // שמור חזרה לקובץ
        var json = JsonSerializer.Serialize(homeworks, new JsonSerializerOptions { WriteIndented = true });
        await File.WriteAllTextAsync(_filePath, json);
      }
    }
  }
