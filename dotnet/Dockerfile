FROM microsoft/dotnet

RUN apt update && apt install -y libunwind8-dev

WORKDIR /release

CMD "/usr/bin/dotnet run"
