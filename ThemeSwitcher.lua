--[[
    NOTHING-UI Theme Switcher
    by louismich4el

    USAGE — add this at the bottom of your script, after creating your Window:

        local ThemeSwitcher = loadstring(game:HttpGet('YOUR_RAW_URL/ThemeSwitcher.lua'))()
        ThemeSwitcher:Init(Windows, ScreenGui)

    A "Settings" tab will be added automatically to your Window.
    Theme choice is saved via writefile so it persists between sessions.
--]]

local ThemeSwitcher = {}

-- ─────────────────────────────────────────────────────────────────────────────
--  THEME DEFINITIONS
-- ─────────────────────────────────────────────────────────────────────────────
local Themes = {
    ["Koeru"] = {
        bg      = Color3.fromRGB(8,   8,  10),
        panel   = Color3.fromRGB(10,  10, 14),
        accent  = Color3.fromRGB(180, 210, 240),
        text    = Color3.fromRGB(230, 235, 245),
        subtext = Color3.fromRGB(140, 150, 165),
        element = Color3.fromRGB(14,  14, 20),
        stroke  = Color3.fromRGB(180, 200, 220),
        shadow  = Color3.fromRGB(160, 190, 220),
    },
    ["Midnight"] = {
        bg      = Color3.fromRGB(5,   5,  15),
        panel   = Color3.fromRGB(9,   9,  22),
        accent  = Color3.fromRGB(100, 120, 255),
        text    = Color3.fromRGB(220, 220, 255),
        subtext = Color3.fromRGB(120, 120, 180),
        element = Color3.fromRGB(12,  12, 28),
        stroke  = Color3.fromRGB(100, 120, 255),
        shadow  = Color3.fromRGB(60,  80,  200),
    },
    ["Crimson"] = {
        bg      = Color3.fromRGB(10, 5,   5),
        panel   = Color3.fromRGB(18, 8,   8),
        accent  = Color3.fromRGB(220, 50, 70),
        text    = Color3.fromRGB(245, 220, 220),
        subtext = Color3.fromRGB(165, 110, 110),
        element = Color3.fromRGB(22,  10, 10),
        stroke  = Color3.fromRGB(200, 60, 80),
        shadow  = Color3.fromRGB(180, 30, 50),
    },
    ["Forest"] = {
        bg      = Color3.fromRGB(5,  10, 5),
        panel   = Color3.fromRGB(8,  16, 8),
        accent  = Color3.fromRGB(60, 200, 100),
        text    = Color3.fromRGB(210, 240, 210),
        subtext = Color3.fromRGB(110, 160, 110),
        element = Color3.fromRGB(10,  20, 10),
        stroke  = Color3.fromRGB(60,  200, 100),
        shadow  = Color3.fromRGB(30,  140, 60),
    },
    ["Ghost"] = {
        bg      = Color3.fromRGB(18, 18, 18),
        panel   = Color3.fromRGB(24, 24, 24),
        accent  = Color3.fromRGB(255, 255, 255),
        text    = Color3.fromRGB(255, 255, 255),
        subtext = Color3.fromRGB(160, 160, 160),
        element = Color3.fromRGB(28,  28, 28),
        stroke  = Color3.fromRGB(220, 220, 220),
        shadow  = Color3.fromRGB(200, 200, 200),
    },
    ["Sunset"] = {
        bg      = Color3.fromRGB(12, 6,  3),
        panel   = Color3.fromRGB(20, 10, 4),
        accent  = Color3.fromRGB(255, 140, 50),
        text    = Color3.fromRGB(255, 230, 200),
        subtext = Color3.fromRGB(180, 130, 90),
        element = Color3.fromRGB(25,  13, 5),
        stroke  = Color3.fromRGB(255, 140, 50),
        shadow  = Color3.fromRGB(200, 80,  20),
    },
    ["Neon"] = {
        bg      = Color3.fromRGB(5,  5,  5),
        panel   = Color3.fromRGB(8,  8,  8),
        accent  = Color3.fromRGB(0,  255, 180),
        text    = Color3.fromRGB(200, 255, 240),
        subtext = Color3.fromRGB(100, 180, 155),
        element = Color3.fromRGB(10,  10, 10),
        stroke  = Color3.fromRGB(0,   255, 180),
        shadow  = Color3.fromRGB(0,   180, 120),
    },
    ["Ocean"] = {
        bg      = Color3.fromRGB(4,  10, 18),
        panel   = Color3.fromRGB(6,  16, 28),
        accent  = Color3.fromRGB(40, 180, 255),
        text    = Color3.fromRGB(210, 240, 255),
        subtext = Color3.fromRGB(110, 160, 200),
        element = Color3.fromRGB(8,   20, 36),
        stroke  = Color3.fromRGB(40,  180, 255),
        shadow  = Color3.fromRGB(20,  120, 200),
    },
    ["Violet"] = {
        bg      = Color3.fromRGB(10, 6,  16),
        panel   = Color3.fromRGB(16, 9,  26),
        accent  = Color3.fromRGB(160, 80, 255),
        text    = Color3.fromRGB(235, 220, 255),
        subtext = Color3.fromRGB(150, 120, 200),
        element = Color3.fromRGB(20,  11, 32),
        stroke  = Color3.fromRGB(160, 80, 255),
        shadow  = Color3.fromRGB(110, 40, 200),
    },
    ["Rose Gold"] = {
        bg      = Color3.fromRGB(14, 9,  9),
        panel   = Color3.fromRGB(22, 13, 12),
        accent  = Color3.fromRGB(220, 150, 120),
        text    = Color3.fromRGB(255, 235, 225),
        subtext = Color3.fromRGB(185, 145, 130),
        element = Color3.fromRGB(28,  16, 14),
        stroke  = Color3.fromRGB(220, 150, 120),
        shadow  = Color3.fromRGB(180, 100, 70),
    },
    ["Abyss"] = {
        bg      = Color3.fromRGB(3,  3,  6),
        panel   = Color3.fromRGB(5,  5,  10),
        accent  = Color3.fromRGB(80, 100, 220),
        text    = Color3.fromRGB(200, 205, 230),
        subtext = Color3.fromRGB(100, 105, 145),
        element = Color3.fromRGB(7,   7,  14),
        stroke  = Color3.fromRGB(60,  80, 180),
        shadow  = Color3.fromRGB(40,  55, 150),
    },
    ["Candy"] = {
        bg      = Color3.fromRGB(16, 6,  14),
        panel   = Color3.fromRGB(24, 8,  20),
        accent  = Color3.fromRGB(255, 80, 200),
        text    = Color3.fromRGB(255, 220, 248),
        subtext = Color3.fromRGB(190, 130, 180),
        element = Color3.fromRGB(30,  10, 25),
        stroke  = Color3.fromRGB(255, 80, 200),
        shadow  = Color3.fromRGB(200, 40, 160),
    },
    ["Sakura"] = {
        bg      = Color3.fromRGB(20, 10, 14),
        panel   = Color3.fromRGB(30, 14, 20),
        accent  = Color3.fromRGB(255, 182, 210),
        text    = Color3.fromRGB(255, 235, 245),
        subtext = Color3.fromRGB(200, 160, 180),
        element = Color3.fromRGB(36,  16, 24),
        stroke  = Color3.fromRGB(255, 182, 210),
        shadow  = Color3.fromRGB(230, 120, 170),
    },
    ["Lavender"] = {
        bg      = Color3.fromRGB(12, 10, 18),
        panel   = Color3.fromRGB(18, 14, 28),
        accent  = Color3.fromRGB(190, 160, 255),
        text    = Color3.fromRGB(240, 235, 255),
        subtext = Color3.fromRGB(160, 145, 205),
        element = Color3.fromRGB(22,  17, 34),
        stroke  = Color3.fromRGB(190, 160, 255),
        shadow  = Color3.fromRGB(140, 100, 230),
    },
}

-- ─────────────────────────────────────────────────────────────────────────────
--  HELPERS
-- ─────────────────────────────────────────────────────────────────────────────
local TweenService = game:GetService("TweenService")
local TI = TweenInfo.new(0.4, Enum.EasingStyle.Quint)

local function Tween(obj, props)
    TweenService:Create(obj, TI, props):Play()
end

local function SaveTheme(name)
    if writefile then
        pcall(writefile, "koeru_theme.txt", name)
    end
end

local function LoadTheme()
    if readfile and isfile and isfile("koeru_theme.txt") then
        local ok, val = pcall(readfile, "koeru_theme.txt")
        if ok and Themes[val] then return val end
    end
    return "Koeru"
end

-- ─────────────────────────────────────────────────────────────────────────────
--  APPLY THEME — walks ScreenGui and re-colours every known element
-- ─────────────────────────────────────────────────────────────────────────────
local function ApplyTheme(screenGui, theme)
    for _, obj in ipairs(screenGui:GetDescendants()) do
        local name = obj.Name

        if name == "MainFrame" and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.bg })

        elseif (name == "TabButtonFrame" or name == "MainTabFrame") and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.panel })

        elseif name == "Headers" and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.panel })

        elseif name == "DropdownFrame" and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.panel })

        elseif (name == "FunctionToggle" or name == "FunctionButton"
            or name == "FunctionSlider" or name == "FunctionKeybind"
            or name == "FunctionDropdown" or name == "FunctionTextbox"
            or name == "FunctionTitle") and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.element })

        elseif name == "TabButton" and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.panel })

        elseif name == "Section" and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.panel })

        elseif name == "MainDropShadow" and obj:IsA("ImageLabel") then
            Tween(obj, { ImageColor3 = theme.shadow })

        elseif name == "MiniDropShadow" and obj:IsA("ImageLabel") then
            Tween(obj, { ImageColor3 = theme.shadow })

        elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
            if name == "Title" or name == "TextInt" or name == "ValueId" or name == "ValueText" then
                Tween(obj, { TextColor3 = theme.text })
            elseif name == "Description" then
                Tween(obj, { TextColor3 = theme.subtext })
            end

        elseif obj:IsA("UIStroke") then
            Tween(obj, { Color = theme.stroke })

        elseif name == "Frame" and obj:IsA("Frame") then
            local par = obj.Parent
            if par and par.Name == "TabButton" then
                Tween(obj, { BackgroundColor3 = theme.accent })
            end

        elseif name == "Icon" and obj:IsA("Frame") then
            if obj.Parent and obj.Parent.Name == "System" then
                Tween(obj, { BackgroundColor3 = theme.accent })
            end

        elseif name == "Fill" and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.accent })

        elseif name == "GLImage" and obj:IsA("ImageLabel") then
            Tween(obj, { ImageColor3 = theme.accent })
        end
    end
end

-- ─────────────────────────────────────────────────────────────────────────────
--  PUBLIC API
-- ─────────────────────────────────────────────────────────────────────────────
function ThemeSwitcher:Init(Window, ScreenGui)
    assert(Window,    "[ThemeSwitcher] Window is nil — pass your Window table")
    assert(ScreenGui, "[ThemeSwitcher] ScreenGui is nil — pass your ScreenGui instance")

    local currentThemeName = LoadTheme()
    local currentTheme     = Themes[currentThemeName]
    local pendingThemeName = currentThemeName

    -- Apply saved theme right away
    task.defer(function()
        ApplyTheme(ScreenGui, currentTheme)
    end)

    -- Sorted theme name list for dropdown
    local themeNames = {}
    for k in pairs(Themes) do
        table.insert(themeNames, k)
    end
    table.sort(themeNames)

    -- ── Settings tab  (settings icon from Lucide: "settings-2")  ──────────
    -- Lucide icon name used by the library's icon resolver
    local SettingsTab = Window:NewTab({
        Title       = "Settings",
        Description = "Customise your UI",
        Icon        = "settings-2",   -- Lucide icon: gear/cog
    })

    -- ── Theme section ─────────────────────────────────────────────────────
    local ThemeSection = SettingsTab:NewSection({
        Title    = "Colour Theme",
        Icon     = "palette",          -- Lucide icon: palette
        Position = "Left",
    })

    -- Dropdown — selecting previews live, button saves
    ThemeSection:NewDropdown({
        Title    = "Select Theme",
        Data     = themeNames,
        Default  = currentThemeName,
        Callback = function(selected)
            if not Themes[selected] then return end
            pendingThemeName = selected
            -- Live preview
            ApplyTheme(ScreenGui, Themes[selected])
        end,
    })

    ThemeSection:NewButton({
        Title    = "Apply & Save Theme",
        Callback = function()
            currentThemeName = pendingThemeName
            currentTheme     = Themes[currentThemeName]
            ApplyTheme(ScreenGui, currentTheme)
            SaveTheme(currentThemeName)
        end,
    })

    ThemeSection:NewButton({
        Title    = "Reset to Default (Koeru)",
        Callback = function()
            pendingThemeName = "Koeru"
            currentThemeName = "Koeru"
            currentTheme     = Themes["Koeru"]
            ApplyTheme(ScreenGui, currentTheme)
            SaveTheme("Koeru")
        end,
    })

    -- ── UI section ────────────────────────────────────────────────────────
    local UISection = SettingsTab:NewSection({
        Title    = "Interface",
        Icon     = "monitor",          -- Lucide icon
        Position = "Left",
    })

    UISection:NewButton({
        Title    = "Destroy UI",
        Callback = function()
            pcall(function() ScreenGui:Destroy() end)
        end,
    })

    -- ── Expose programmatic API ───────────────────────────────────────────
    function self:SetTheme(name)
        local theme = Themes[name]
        if not theme then
            warn("[ThemeSwitcher] Unknown theme: " .. tostring(name))
            return
        end
        pendingThemeName = name
        currentThemeName = name
        currentTheme     = theme
        ApplyTheme(ScreenGui, theme)
        SaveTheme(name)
    end

    function self:GetTheme()
        return currentThemeName, currentTheme
    end

    function self:AddTheme(name, themeData)
        assert(type(name) == "string",     "[ThemeSwitcher] name must be a string")
        assert(type(themeData) == "table", "[ThemeSwitcher] themeData must be a table")
        Themes[name] = themeData
    end

    return self
end

return ThemeSwitcher
