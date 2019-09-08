#pragma once
#include <string>
#include <vector>
#include "Ultralight/Ultralight.h"
#include <JavaScriptCore/JavaScript.h>

class PageLoadListener : public ultralight::LoadListener {
public:
	///
	/// Called when the page begins loading new URL into main frame
	///
	void OnBeginLoading(ultralight::View* caller) {
		Com_Printf("^5Ultralight: ^7Begin Loading...\n");
	}

	///
	/// Called when the page finishes loading URL into main frame
	///
	void OnFinishLoading(ultralight::View* caller) {
		Com_Printf("^5Ultralight: ^7Finished Loading...\n");
		caller->bitmap()->WritePNG("UltralightSnapshot.png");
	}

	///
	/// Called when the history (back/forward state) is modified
	///
	void OnUpdateHistory(ultralight::View* caller) {
		Com_Printf("^5Ultralight: ^7Update History...\n");
	}

	///
	/// Called when all JavaScript has been parsed and the document is ready.
	/// This is the best time to make any initial JavaScript calls to your page.
	///
	void OnDOMReady(ultralight::View* caller) {
		Com_Printf("^5Ultralight: ^7DOM Ready...\n");
	}

	~PageLoadListener() {

	}
};


void UI_Ultralight_Init(void);
void UI_Ultralight_Update(void);
void UI_Ultralight_Render(void);
void UI_Ultralight_KeyEvent(int key, qboolean down);
void UI_Ultralight_MouseEvent(int dx, int dy);
void UI_Ultralight_Shutdown(void);