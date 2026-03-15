FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# העתקת הכל פנימה
COPY . .

# הרצת ה-Restore על כל הקבצים שמסתיימים ב-csproj בכל התיקיות
RUN dotnet restore "**/*.csproj"

# בנייה של פרויקט ה-API הראשי
RUN dotnet publish "Angular Test WebAPI/Angular Test WebAPI.csproj" -c Release -o /app/publish

# שלב ההרצה
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Angular Test WebAPI.dll"]