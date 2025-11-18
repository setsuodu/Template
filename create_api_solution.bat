@echo off
:: 设置 CMD 编码为 UTF-8 (代码页 65001)，解决中文乱码问题
chcp 65001 > nul

SET SOLUTION_NAME=WebAPI
SET WEATHER_PROJECT=WeatherService
SET GATEWAY_PROJECT=ApiGateway

echo -----------------------------------------------------------------
echo 🚀 开始创建 ASP.NET Core 项目结构 (WebAPI 解决方案)...
echo -----------------------------------------------------------------

:: 1. 创建解决方案文件夹和文件
echo 1. 创建解决方案目录和文件...
mkdir %SOLUTION_NAME%
cd %SOLUTION_NAME%
dotnet new sln -n %SOLUTION_NAME%

:: 2. 创建 src 文件夹
echo 2. 创建 src 目录...
mkdir src
cd src

:: 3. 创建 WeatherService (WebAPI 模板)
echo 3. 创建 %WEATHER_PROJECT% (webapi 模板)...
dotnet new webapi -n %WEATHER_PROJECT% --no-https --output %WEATHER_PROJECT%

:: 4. 创建 ApiGateway (Library 模板，仅创建 csproj 文件)
:: 很多 ApiGateway 只是配置，用 library 模板创建最小的 csproj
echo 4. 创建 %GATEWAY_PROJECT% (library 模板)...
dotnet new classlib -n %GATEWAY_PROJECT% --output %GATEWAY_PROJECT%

:: 5. 将项目添加到解决方案
echo 5. 将项目添加到解决方案文件...
cd ..
dotnet sln add src/%WEATHER_PROJECT%/%WEATHER_PROJECT%.csproj
dotnet sln add src/%GATEWAY_PROJECT%/%GATEWAY_PROJECT%.csproj

:: 6. 为 WeatherService 项目创建 Dockerfile 并配置正确的上下文
echo 6. 为 %WEATHER_PROJECT% 创建 Dockerfile 并配置上下文...
(
    echo FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
    echo WORKDIR /app
    echo EXPOSE 8080

    echo FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
    echo WORKDIR /src
    echo COPY ["src/%WEATHER_PROJECT%/%WEATHER_PROJECT%.csproj", "src/%WEATHER_PROJECT%/"]
    echo RUN dotnet restore "src/%WEATHER_PROJECT%/%WEATHER_PROJECT%.csproj"

    echo COPY . .
    echo WORKDIR "/src/src/%WEATHER_PROJECT%"
    echo RUN dotnet build "%WEATHER_PROJECT%.csproj" -c Release -o /app/build

    echo FROM build AS publish
    echo RUN dotnet publish "%WEATHER_PROJECT%.csproj" -c Release -o /app/publish /p:UseAppHost=false

    echo FROM base AS final
    echo WORKDIR /app
    echo COPY --from=publish /app/publish .
    echo ENTRYPOINT ["dotnet", "%WEATHER_PROJECT%.dll"]
) > src/%WEATHER_PROJECT%/Dockerfile

:: 7. 清理和完成
echo -----------------------------------------------------------------
echo ✅ 项目创建完成!
echo -----------------------------------------------------------------
echo 解决方案路径: .\%SOLUTION_NAME%
echo 包含项目: %WEATHER_PROJECT% 和 %GATEWAY_PROJECT%
echo Dockerfile 位置: .\%SOLUTION_NAME%\src\%WEATHER_PROJECT%\Dockerfile
echo.
pause