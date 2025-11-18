local M = {}
local ffi = require("ffi")

-- 1. FFI Declaration
-- We declare the signature of the Windows API function PostMessageA.
-- PostMessageA: BOOL PostMessageA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam)
ffi.cdef([[
    typedef unsigned long DWORD;
    typedef void* HANDLE;
    typedef HANDLE HWND;
    typedef unsigned int UINT;
    typedef uintptr_t WPARAM;
    typedef intptr_t LPARAM;
    typedef int BOOL;

    BOOL PostMessageA(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
]])

-- 2. Load the DLL
-- This loads the User32.dll library once when the module is loaded.
local user32 = ffi.load("user32")

-- 3. Define Constants
-- These are the critical values passed to PostMessageA.
local WM_INPUTLANGCHANGEREQUEST = 0x0050
local ENGLISH_US_LAYOUT_ID = 0x04090409

-- Function to get the current Neovim window handle (HWND)
-- This is the trickiest part. In a console or terminal emulator, Neovim runs
-- inside the terminal, so you need the terminal's window handle.
-- In Neovim-Qt or gVim-style UIs, you need the main window's handle.
-- A common way to get the *foreground* window handle in a standard terminal:
local function get_foreground_window_handle()
	-- This relies on DllCall for GetForegroundWindow()
	-- Since we're in Lua, we need to declare this function too:
	ffi.cdef([[
        HWND GetForegroundWindow(void);
    ]])
	return user32.GetForegroundWindow()
end

-- 4. The Core Function
function M.force_switch_to_english()
	local target_hWnd = get_foreground_window_handle()

	if target_hWnd == nil then
		-- Handle case where HWND couldn't be retrieved (e.g., WSL, unusual terminal)
		print("Could not retrieve window handle for language switch.")
		return
	end

	-- Call PostMessageA to send the language change request
	local success = user32.PostMessageA(
		target_hWnd,
		WM_INPUTLANGCHANGEREQUEST,
		0, -- wParam
		ENGLISH_US_LAYOUT_ID -- lParam (the desired locale ID)
	)

	if success == 0 then
		-- Error handling
		-- print("Error sending WM_INPUTLANGCHANGEREQUEST.")
	end
end
vim.api.nvim_create_autocmd("InsertLeave", {
	-- nested = true,
	callback = M.force_switch_to_english,
})

return M
