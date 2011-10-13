BUILDER=C:/WINDOWS/Microsoft.NET/Framework/v3.5/msbuild.exe

SOLUTION=$(wildcard *.slu)

all:
	${BUILDER} ${SOLUTION}\
		/p:Configuration=Release \
		/p:WarningLevel=0 /nologo \ verbosity:quiet
