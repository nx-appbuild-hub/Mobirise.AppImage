# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir/mobirise
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0

	wget --output-document=$(PWD)/build/build.deb https://download.mobirise.com/MobiriseSetup.deb
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	cp --force --recursive $(PWD)/build/opt/Mobirise*/* $(PWD)/build/Boilerplate.AppDir/mobirise
	cp --force --recursive $(PWD)/build/usr/share/* $(PWD)/build/Boilerplate.AppDir/share

	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:$${APPDIR}/mobirise' 					>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}' 								>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo '' 																		>> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo 'exec $${APPDIR}/mobirise/mobirise "$${@}"' 								>> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm --force $(PWD)/build/Boilerplate.AppDir/*.svg        || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop    || true
	rm --force $(PWD)/build/Boilerplate.AppDir/*.png        || true

	cp --force $(PWD)/AppDir/*.png 			$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.desktop 		$(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg 			$(PWD)/build/Boilerplate.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool-x86_64.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Mobirise.AppImage
	chmod +x $(PWD)/Mobirise.AppImage


clean:
	rm -rf $(PWD)/build
