FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# העתקת כל הקבצים
COPY . .

# הרצת Restore ספציפית על הפרויקט הראשי 
# (הוא כבר ימשוך לבד את התלויות של BL, DAL ו-DTO כי הם מקושרים אליו)
RUN dotnet restore "Angular Test WebAPI/Angular Test WebAPI.csproj"

# בנייה של פרויקט ה-API הראשי
RUN dotnet publish "Angular Test WebAPI/Angular Test WebAPI.csproj" -c Release -o /app/publish

# שלב ההרצה
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

ENTRYPOINT ["dotnet", "Angular Test WebAPI.dll"]