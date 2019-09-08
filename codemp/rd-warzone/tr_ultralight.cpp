/*
===========================================================================
Copyright (C) 2013 - 2015, OpenJK contributors

This file is part of the OpenJK source code.

OpenJK is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License version 2 as
published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, see <http://www.gnu.org/licenses/>.
===========================================================================
*/

// cl_main.c  -- client main loop

#include "tr_local.h"
#include "tr_ultralight.h"

using namespace ultralight;
bool ultralight_menuOpened = false;




// Injector
void UI_Injector_WriteMemory(void) {

}

// OpenGL 

void UI_OGL_CreateContext(void) {


}

void UI_OGL_Drawoverlay(void) {

}

//
RefPtr<Renderer> _renderer;
RefPtr<View> _view;
PageLoadListener listener;

void UI_Ultralight_LoadMenus(void) {
	fileHandle_t h;
	size_t len = ri->FS_FOpenFileByMode("menus/html/main.html", &h, FS_READ);
	if (!h) {
		Com_Printf("^5Ultralight: ^7Failed to open file.\n");
	}
	char* str = (char*)malloc(len + 1);
	if (!str) {
		Com_Printf("^5Ultralight ^1ERR: ^7failed to allocate memory\n");
		return;
	}
	ri->FS_Read(str, len, h);
	String buffer(str);
	_view->LoadHTML(buffer);
	Com_Printf("^5Ultralight: ^7Attempting to load html file...\n");
	ri->FS_FCloseFile(h);
	free(str);
}

void UI_Ultralight_Init(void) {
	Com_Printf("^5Ultralight: ^7Init..\n");
	_renderer = Renderer::Create();
	_view = _renderer->CreateView(glConfig.vidWidth, glConfig.vidHeight, false);
	_view->set_load_listener(&listener);
	Com_Printf("^5Ultralight: ^7Init done..\n");
	UI_Ultralight_LoadMenus();
}

void UI_Ultralight_Update(void) {
	_renderer->Update();
	_renderer->Render();
}

void UI_Ultralight_Render(void) {
	RefPtr<Bitmap> bm = _view->bitmap();
	bm->LockPixels();
	R_UpdateSubImage(tr.ultralightImage , (byte*)bm->raw_pixels(), 0, 0, bm->width(), bm->height());
	bm->UnlockPixels();
	FBO_BlitFromTexture(tr.ultralightImage, NULL, NULL, tr.renderFbo, NULL, NULL, NULL, GLS_SRCBLEND_DST_COLOR | GLS_DSTBLEND_ZERO); // GLS_SRCBLEND_DST_COLOR | GLS_DSTBLEND_ZERO
}

void UI_Ultralight_KeyEvent(int key, qboolean down) {
	KeyEvent ke;
	ke.native_key_code = key;
	_view->FireKeyEvent(ke);
}

void UI_Ultralight_MouseEvent(int x, int y) {
	MouseEvent me;
	me.x = x;
	me.y = y;
	_view->FireMouseEvent(me);

}

void UI_Ultralight_Shutdown(void) {
	_view->Release();
	_renderer->Release();
}