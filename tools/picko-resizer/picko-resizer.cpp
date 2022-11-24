#include <stdio.h>
#include <windows.h>

bool resize(HWND hwnd, float multiplier) {
	WINDOWINFO wi;
	if (!GetWindowInfo(hwnd, &wi)) return false;

	int width = 256 * multiplier;
	int height = 192 * multiplier;
	printf("Desginated client size %d x %d\n", width, height);

	RECT rect = wi.rcClient;
	rect.right = rect.left + width;
	rect.bottom = rect.top + height;
	AdjustWindowRectEx(&rect, wi.dwStyle, false, wi.dwExStyle);
	width = rect.right - rect.left;
	height = rect.bottom - rect.top;
	printf("Calculated window size %d x %d\n", width, height);

	return SetWindowPos(hwnd, HWND_TOP, rect.left, rect.top, width, height, 0) != 0;
}

int __stdcall callback(HWND hwnd, LPARAM lParam) {
	char buf[1024];
	UINT len = GetWindowTextA(hwnd, buf, 1023);
	if (!len) return 1;

	if (strncmp(buf, "PICKO", 5) == 0 && strncmp(buf, "PICKO DEBUG CONSOLE", 19) != 0) {
		printf("Window found, window title: %s\n", buf);

		float multiplier = *(float*)lParam;
		if (resize(hwnd, multiplier)) SetLastError(0);
		return 0;
	}

	return 1;
}

int main(int argc, char* argv[]) {
	float multiplier = 1.0;
	if (argc >= 2) sscanf(argv[1], "%f", &multiplier);
	printf("Will resize PICKO window to %gx canvas size\n", multiplier);

	if (EnumWindows(callback, (LPARAM)&multiplier)) {
		printf("Error: PICKO window not found\n");
		return 2;
	}

	DWORD error = GetLastError();
	if (error) {
		printf("Error: System error %d\n", error);
		return 1;
	}

	return 0;
}
