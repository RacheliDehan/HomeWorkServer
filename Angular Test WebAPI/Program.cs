using BL;
using DAL;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at http://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IUserService, UserService>();

builder.Services.AddCors(options =>
{
  options.AddPolicy("AllowAngular",
      policy =>
      {
        policy     
                .WithOrigins("http://localhost:4200", "https://homework-3bsa.onrender.com/") 
                .AllowAnyHeader()                  
                .AllowAnyMethod()                  
                .AllowCredentials();               
      });
});


var app = builder.Build();

app.UseRouting();
app.UseCors("AllowAngular");


app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();
// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
  app.UseSwagger();
  app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();

