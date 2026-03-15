# שלב הבנייה
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# העתקת כל הפרויקטים (השכבות)
COPY ["Angular Test WebAPI/Angular Test WebAPI.csproj", "Angular Test WebAPI/"]
COPY ["BL/BL.csproj", "BL/"]
COPY ["DL/DL.csproj", "DL/"]
COPY ["DTO/DTO.csproj", "DTO/"]

# הרצת Restore
RUN dotnet restore "Angular Test WebAPI/Angular Test WebAPI.csproj"

# העתקת כל השאר ובנייה
COPY . .
RUN dotnet publish "Angular Test WebAPI/Angular Test WebAPI.csproj" -c Release -o /app/publish

# שלב ההרצה
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .

# הגדרת פורט ל-Render
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Angular Test WebAPI.dll"]