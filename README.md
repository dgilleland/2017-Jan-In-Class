# 2017-Jan-In-Class
## CPSC-1517 - Introduction to App-Dev

When downloading these code samples and running them in Visual Studio, you will need to open the Package Manager console (Tools->NuGet Pakcage Manager->Package Manager Console) and then type in the following line and press [Enter].

`update-package -r`

## Gotcha's

If I'm missing roslyn/cs.exe when I run it (CTRL + F5), then

* Open **Tools>NuGet Package Manager>Package Manager Console...**
* Type `update-package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r`
* If you are still having problems, also type the following in the Package Manager Console:
  * `update-package -reinstall`
