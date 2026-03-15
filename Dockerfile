FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# העתקת הכל (כמו שעשינו וזה עבד)
COPY . .

# במקום לרשום את שם הקובץ, אנחנו נותנים לו את הנתיב לתיקייה. 
# ה-dotnet build כבר ימצא לבד את ה-csproj שנמצא בפנים.
RUN dotnet restore "Angular Test WebAPI/"
RUN dotnet publish "Angular Test WebAPI/" -c Release -o /app/publish

# שלב ההרצה
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# הפקודה הזו מריצה את ה-DLL. אם השם של ה-DLL שונה, נראה את זה ב-Log הבא.
ENTRYPOINT ["dotnet", "Angular Test WebAPI.dll"]