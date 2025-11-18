# 1. 创建模板

1. 找到要做模板的仓库 👉 Settings → General → ✅Template repository
2. 返回仓库主页，出现 ![](https://img.shields.io/badge/Use_this_template_▾-2EA44F?style=flat)（说明可被作为模板）

# 2. 使用模板创建新仓库

1. 点击 “Use this template” → 选择 “Create a new repository”。
2. 填写新仓库信息：名称，简介，Public / Private
3. （可选）勾选 “Include all branches”
  - 默认只复制 main/master 分支。
  - 勾选后会把模板的所有分支都复制过来（一般不需要）。
4. 点击 “Create repository from template”。

# 3. 本模板功能

1. CI 自动构建多平台包（docker镜像、steam用的DedicatedServer.exe）
2. src结构，Dockerfile上下文准确
```
cd ..\ServerSamples\StandardAPI
dotnet new sln -n StandardAPI
mkdir src && cd src

dotnet new webapi -n ApiGateway -o ApiGateway
dotnet new webapi -n WebApi -o WebApi

cd ..
dotnet sln add src/ApiGateway/ApiGateway.csproj
dotnet sln add src/WebApi/WebApi.csproj
````
3. Unity自动构建AA/AB