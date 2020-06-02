# Dockerfile for an Arch instance with full desktop

FROM oddlid/arch-cli
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN pacman -Syy
RUN pacman -R --noconfirm --nodeps --nodeps vim \
		&& \
		pacman -S --noconfirm --needed \
		adobe-source-code-pro-fonts \
		adobe-source-sans-pro-fonts \
		adobe-source-serif-pro-fonts \
		awesome \
		cantarell-fonts \
		chromium \
		dina-font \
		dmenu \
		evince \
		ffmpeg \
		firefox \
		font-bh-ttf \
		font-bitstream-speedo \
		gnome-keyring \
		gnu-free-fonts \
		gst-libav \
		gst-plugins-base \
		gst-plugins-good \
		gst-plugins-good \
		gvfs \
		gvim \
		i3 \
		icedtea-web \
		jre8-openjdk \
		keepassx \
		notification-daemon \
		opera \
		pcmanfm \
		pidgin \
		pidgin-libnotify \
		pidgin-otr \
		rlwrap \
		tamsyn-font \
		terminus-font \
		texlive-bin \
		ttf-anonymous-pro \
		ttf-bitstream-vera \
		ttf-dejavu \
		ttf-droid \
		ttf-freefont \
		ttf-inconsolata \
		ttf-liberation \
		ttf-linux-libertine \
		ttf-ubuntu-font-family \
		webkit2gtk \
		xarchiver \
		xfce4-terminal \
		xorg-fonts-100dpi \
		xorg-fonts-75dpi \
		xorg-fonts-alias \
		xorg-fonts-misc \
		xorg-fonts-type1 \
		xterm \
		&& \
		rm -rf /var/cache/pacman/pkg/*

#		&& \
#		sudo -u oddee yaourt -S --noconfirm --needed google-chrome \
#CMD ["bash"]
