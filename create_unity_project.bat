@echo off
chcp 65001 > nul
SET PROJECT_NAME=MyCleanUnityProject

echo ---------------------------------------------------
echo 🚀 开始创建 Unity 项目: %PROJECT_NAME%
echo ---------------------------------------------------

:: 1. 创建项目根目录
echo 1. 创建核心目录...
mkdir %PROJECT_NAME%
cd %PROJECT_NAME%
mkdir Assets
mkdir Packages
mkdir ProjectSettings
mkdir Logs

:: 2. 创建 Packages/manifest.json 文件 (定义依赖)
echo 2. 配置 Packages/manifest.json 依赖...
(
    echo {
    echo   "dependencies": {
    echo     "com.unity.ide.visualstudio": "2.0.25",
    echo     "com.unity.ugui": "1.0.0",
    echo     "com.unity.test-framework": "1.1.33",
    echo     "com.unity.modules.ui": "1.0.0"
    echo   },
    echo   "testables": []
    echo }
) > Packages\manifest.json

:: 3. 创建 ProjectSettings/ProjectSettings.asset (最小化配置)
:: 仅创建一个空的 ProjectSettings.asset 文件，Unity启动时会填充其他默认值
echo 3. 创建 ProjectSettings/ProjectSettings.asset...
(
    echo %YAML 1.1%
    echo %TAG !u! tag:unity3d.com,2011:
    echo --- !u!1001 &1
    echo EditorSettings:
) > ProjectSettings\ProjectSettings.asset

:: 4. 创建 ProjectVersion.txt (指定Unity版本)
:: 必须有这个文件，Editor才能识别项目版本
echo 4. 创建 ProjectVersion.txt (设定版本)...
echo m_EditorVersion: 2022.3.17f1 > ProjectVersion.txt

:: 5. 完成
echo ---------------------------------------------------
echo ✅ Unity项目结构创建完成!
echo ---------------------------------------------------
echo 路径: .\%PROJECT_NAME%
echo 依赖: com.unity.ugui (1.0.0), com.unity.ide.visualstudio (2.0.25)
echo.
pause