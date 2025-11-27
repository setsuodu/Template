@echo off
:: 设置 CMD 编码为 UTF-8 (代码页 65001)，解决中文乱码问题
chcp 65001 > nul

SET PROJECT_NAME=Unity
SET UNITY_VERSION=2022.3.62f2c1

echo ---------------------------------------------------
echo 🚀 开始创建 Unity 项目模板: %PROJECT_NAME%
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
:: 若不写这么大一段，Unity初次启动项目，会自动生成更多（再多10+个）
echo 2. 配置 Packages/manifest.json 依赖 (包含 UGUI 和 VS 集成)...
(
    echo {
    echo   "dependencies": {
    echo     "com.unity.ide.visualstudio": "2.0.25",
    echo     "com.unity.ugui": "1.0.0",
    echo     "com.unity.test-framework": "1.1.33",
    echo     "com.unity.modules.ui": "1.0.0"
	echo	 "com.unity.ide.visualstudio": "2.0.25",
	echo	 "com.unity.ugui": "1.0.0",
	echo	 "com.unity.modules.ai": "1.0.0",
	echo	 "com.unity.modules.androidjni": "1.0.0",
	echo	 "com.unity.modules.animation": "1.0.0",
	echo	 "com.unity.modules.assetbundle": "1.0.0",
	echo	 "com.unity.modules.audio": "1.0.0",
	echo	 "com.unity.modules.cloth": "1.0.0",
	echo	 "com.unity.modules.director": "1.0.0",
	echo	 "com.unity.modules.imageconversion": "1.0.0",
	echo	 "com.unity.modules.imgui": "1.0.0",
	echo	 "com.unity.modules.jsonserialize": "1.0.0",
	echo	 "com.unity.modules.particlesystem": "1.0.0",
	echo	 "com.unity.modules.physics": "1.0.0",
	echo	 "com.unity.modules.physics2d": "1.0.0",
	echo	 "com.unity.modules.screencapture": "1.0.0",
	echo	 "com.unity.modules.terrain": "1.0.0",
	echo	 "com.unity.modules.terrainphysics": "1.0.0",
	echo	 "com.unity.modules.tilemap": "1.0.0",
	echo	 "com.unity.modules.ui": "1.0.0",
	echo	 "com.unity.modules.uielements": "1.0.0",
	echo	 "com.unity.modules.umbra": "1.0.0",
	echo	 "com.unity.modules.unityanalytics": "1.0.0",
	echo	 "com.unity.modules.unitywebrequest": "1.0.0",
	echo	 "com.unity.modules.unitywebrequestassetbundle": "1.0.0",
	echo	 "com.unity.modules.unitywebrequestaudio": "1.0.0",
	echo	 "com.unity.modules.unitywebrequesttexture": "1.0.0",
	echo	 "com.unity.modules.unitywebrequestwww": "1.0.0",
	echo	 "com.unity.modules.vehicles": "1.0.0",
	echo	 "com.unity.modules.video": "1.0.0",
	echo	 "com.unity.modules.vr": "1.0.0",
	echo	 "com.unity.modules.wind": "1.0.0",
	echo	 "com.unity.modules.xr": "1.0.0"
    echo   }
    echo }
) > Packages\manifest.json

:: 3. 创建 ProjectSettings/ProjectSettings.asset (最小化配置)
echo 3. 创建 ProjectSettings/ProjectSettings.asset...
(
    echo %YAML 1.1%
    echo %TAG !u! tag:unity3d.com,2011:
    echo --- !u!1001 &1
    echo EditorSettings:
) > ProjectSettings\ProjectSettings.asset

:: 4. 创建 ProjectVersion.txt (指定 Unity 版本)
echo 4. 创建 ProjectVersion.txt (设定版本: %UNITY_VERSION%)...
echo m_EditorVersion: %UNITY_VERSION% > ProjectVersion.txt

:: 5. 完成
echo ---------------------------------------------------
echo ✅ Unity项目模板创建完成!
echo ---------------------------------------------------
echo 路径: .\%PROJECT_NAME%
echo Unity 版本: %UNITY_VERSION%
echo 包含的包: com.unity.ugui (1.0.0), com.unity.ide.visualstudio (2.0.25)
echo.
pause