#
# CannyOS opensuse container with libreoffice
#
# https://github.com/intlabs/cannyos-application-opensuse-gtk3-libreoffice
#
# Copyright 2014 Pete Birley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Pull base image.
FROM intlabs/cannyos-base-opensuse-gtk3

# Set environment variables.
ENV HOME /root

# Set the working directory
WORKDIR /

#****************************************************
#                                                   *
#         INSERT COMMANDS BELLOW THIS               *
#                                                   *
#****************************************************

#Build libreoffice
WORKDIR /CannyOS/Host
RUN zypper remove -y krb5-mini
RUN zypper -n si -d libreoffice
RUN zypper -n install python3-devel
RUN wget http://download.documentfoundation.org/libreoffice/src/4.2.5/libreoffice-4.2.5.2.tar.xz && \
	tar xvfJ libreoffice-4.2.5.2.tar.xz && \
	cd libreoffice* && \
	./autogen.sh --enable-gtk3 --without-java && \
	make && \
	make install

#****************************************************
#                                                   *
#         ONLY PORT RULES BELLOW THIS               *
#                                                   *
#****************************************************

#HTTP (broadway)
EXPOSE 80/tcp

#****************************************************
#                                                   *
#         NO COMMANDS BELLOW THIS                   *
#                                                   *
#****************************************************

#Add startup & post-install script
ADD CannyOS /CannyOS
WORKDIR /CannyOS
RUN chmod +x *.sh

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT ["/CannyOS/startup.sh"]