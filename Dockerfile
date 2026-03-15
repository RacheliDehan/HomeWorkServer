FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# העתקת התיקיות (בדיוק לפי השמות ב-GitHub)
COPY ["Angular Test WebAPI/", "Angular Test WebAPI/"]
COPY ["BL/", "BL/"]
COPY ["DL/", "DL/"]
COPY ["DTO/", "DTO/"]

# הרצת ה-Restore על פרויקט ה-API הראשי
RUN dotnet restore "Angular Test WebAPI/Angular Test WebAPI.csproj"

# העתקת כל שאר הקבצים
COPY . .

# בנייה של ה-API
RUN dotnet publish "Angular Test WebAPI/Angular Test WebAPI.csproj" -c Release -o /app/publish

# שלב ההרצה
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# שם ה-DLL שנוצר הוא כשם ה-csproj הראשי
ENTRYPOINT ["dotnet", "Angular Test WebAPI.dll"]