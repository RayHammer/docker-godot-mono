FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update && apt-get install -y tzdata gnupg ca-certificates wget unzip python3 git git-lfs \
    && ln -fs /usr/share/zoneinfo/Europe /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update && apt-get install -y dotnet-sdk-6.0 nuget \
    && rm -rf /var/lib/apt/lists/*

ENV GODOT_VERSION "4.0.2"
ENV GODOT_TYPE "x86"

RUN wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/mono/Godot_v${GODOT_VERSION}-stable_mono_linux_${GODOT_TYPE}_64.zip \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && unzip Godot_v${GODOT_VERSION}-stable_mono_linux_${GODOT_TYPE}_64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_mono_linux_${GODOT_TYPE}_64/Godot_v${GODOT_VERSION}-stable_mono_linux.${GODOT_TYPE}_64 /usr/local/bin/godot \
    && mv Godot_v${GODOT_VERSION}-stable_mono_linux_${GODOT_TYPE}_64/* /usr/local/bin/ \
    && mkdir -p ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable.mono \
    && wget https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/mono/Godot_v${GODOT_VERSION}-stable_mono_export_templates.tpz \
    && unzip Godot_v${GODOT_VERSION}-stable_mono_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/export_templates/${GODOT_VERSION}.stable.mono \
    && rm -f Godot_v${GODOT_VERSION}-stable_mono_export_templates.tpz Godot_v${GODOT_VERSION}-stable_mono_linux_${GODOT_TYPE}_64.zip
