--[[
    NOTHING-UI Theme Switcher
    by louismich4el

    USAGE — place this AFTER you load the Library and create your Window:

        local ThemeSwitcher = loadstring(game:HttpGet('YOUR_RAW_URL/ThemeSwitcher.lua'))()
        ThemeSwitcher:Init(Window, ScreenGui)   -- pass your Window & ScreenGui

    That's it! A "Theme" tab will be added automatically to your Window.
    Players can change theme at any time; the choice is saved via writefile.
--]]

local ThemeSwitcher = {}

-- ─────────────────────────────────────────────────────────────────────────────
--  THEME DEFINITIONS
--  Each theme has:
--    bg        – main window background
--    panel     – sidebar / content panels
--    accent    – glowing highlight colour (toggle on, active tab bar, etc.)
--    text      – primary label colour
--    subtext   – secondary / description colour
--    element   – individual toggle / button row background
--    stroke    – UIStroke colour on elements
--    shadow    – drop-shadow tint
-- ─────────────────────────────────────────────────────────────────────────────
local Themes = {
    ["Koeru"] = {
        name    = "Koeru",
        bg      = Color3.fromRGB(8,  8,  10),
        panel   = Color3.fromRGB(10, 10, 14),
        accent  = Color3.fromRGB(180, 210, 240),
        text    = Color3.fromRGB(230, 235, 245),
        subtext = Color3.fromRGB(140, 150, 165),
        element = Color3.fromRGB(14, 14, 20),
        stroke  = Color3.fromRGB(180, 200, 220),
        shadow  = Color3.fromRGB(160, 190, 220),
    },
    ["Midnight"] = {
        name    = "Midnight",
        bg      = Color3.fromRGB(5,  5,  15),
        panel   = Color3.fromRGB(9,  9,  22),
        accent  = Color3.fromRGB(100, 120, 255),
        text    = Color3.fromRGB(220, 220, 255),
        subtext = Color3.fromRGB(120, 120, 180),
        element = Color3.fromRGB(12, 12, 28),
        stroke  = Color3.fromRGB(100, 120, 255),
        shadow  = Color3.fromRGB(60,  80, 200),
    },
    ["Crimson"] = {
        name    = "Crimson",
        bg      = Color3.fromRGB(10, 5,  5),
        panel   = Color3.fromRGB(18, 8,  8),
        accent  = Color3.fromRGB(220, 50, 70),
        text    = Color3.fromRGB(245, 220, 220),
        subtext = Color3.fromRGB(165, 110, 110),
        element = Color3.fromRGB(22, 10, 10),
        stroke  = Color3.fromRGB(200, 60, 80),
        shadow  = Color3.fromRGB(180, 30, 50),
    },
    ["Forest"] = {
        name    = "Forest",
        bg      = Color3.fromRGB(5,  10, 5),
        panel   = Color3.fromRGB(8,  16, 8),
        accent  = Color3.fromRGB(60, 200, 100),
        text    = Color3.fromRGB(210, 240, 210),
        subtext = Color3.fromRGB(110, 160, 110),
        element = Color3.fromRGB(10, 20, 10),
        stroke  = Color3.fromRGB(60, 200, 100),
        shadow  = Color3.fromRGB(30, 140, 60),
    },
    ["Ghost"] = {
        name    = "Ghost",
        bg      = Color3.fromRGB(18, 18, 18),
        panel   = Color3.fromRGB(24, 24, 24),
        accent  = Color3.fromRGB(255, 255, 255),
        text    = Color3.fromRGB(255, 255, 255),
        subtext = Color3.fromRGB(160, 160, 160),
        element = Color3.fromRGB(28, 28, 28),
        stroke  = Color3.fromRGB(220, 220, 220),
        shadow  = Color3.fromRGB(200, 200, 200),
    },
    ["Sunset"] = {
        name    = "Sunset",
        bg      = Color3.fromRGB(12, 6,  3),
        panel   = Color3.fromRGB(20, 10, 4),
        accent  = Color3.fromRGB(255, 140, 50),
        text    = Color3.fromRGB(255, 230, 200),
        subtext = Color3.fromRGB(180, 130, 90),
        element = Color3.fromRGB(25, 13, 5),
        stroke  = Color3.fromRGB(255, 140, 50),
        shadow  = Color3.fromRGB(200, 80, 20),
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
--  APPLY THEME  (walks the entire ScreenGui and re-colours everything)
-- ─────────────────────────────────────────────────────────────────────────────
local function ApplyTheme(screenGui, theme)
    -- Walk every descendant and re-colour based on name / class
    for _, obj in ipairs(screenGui:GetDescendants()) do
        local name = obj.Name

        -- ── Backgrounds ────────────────────────────────────────────────────
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

        -- ── Section header frames ──────────────────────────────────────────
        elseif name == "SectionFrame" and obj:IsA("Frame") then
            Tween(obj, { BackgroundColor3 = theme.panel })

        -- ── Drop shadow tint ───────────────────────────────────────────────
        elseif name == "MainDropShadow" and obj:IsA("ImageLabel") then
            Tween(obj, { ImageColor3 = theme.shadow })

        elseif name == "MiniDropShadow" and obj:IsA("ImageLabel") then
            Tween(obj, { ImageColor3 = theme.shadow })

        -- ── Text labels ────────────────────────────────────────────────────
        elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
            if name == "Title" or name == "TextInt" or name == "ValueId" then
                Tween(obj, { TextColor3 = theme.text })
            elseif name == "Description" then
                Tween(obj, { TextColor3 = theme.subtext })
            end

        -- ── UIStrokes ──────────────────────────────────────────────────────
        elseif obj:IsA("UIStroke") then
            Tween(obj, { Color = theme.stroke })

        -- ── Accent: active tab side bar, toggle icon, slider fill ──────────
        elseif name == "Frame" and obj:IsA("Frame") then
            -- Tab accent bar (the little pill on the right of each tab)
            local par = obj.Parent
            if par and par.Name == "TabButton" then
                Tween(obj, { BackgroundColor3 = theme.accent })
            end

        elseif name == "Icon" and obj:IsA("Frame") then
            -- Toggle knob
            if obj.Parent and obj.Parent.Name == "System" then
                Tween(obj, { BackgroundColor3 = theme.accent })
            end

        elseif name == "Fill" and obj:IsA("Frame") then
            -- Slider fill bar
            Tween(obj, { BackgroundColor3 = theme.accent })

        elseif name == "GLImage" and obj:IsA("ImageLabel") then
            -- Animated gradient orb accent
            Tween(obj, { ImageColor3 = theme.accent })
        end
    end
end

-- ─────────────────────────────────────────────────────────────────────────────
--  PUBLIC: Init
--  Call this right after creating your Window.
--
--  Usage:
--    ThemeSwitcher:Init(Window, ScreenGui)
--
--  If you already have a "Settings" or "Misc" tab you want to put it in,
--  pass it as the third argument:
--    ThemeSwitcher:Init(Window, ScreenGui, ExistingTab)
-- ─────────────────────────────────────────────────────────────────────────────
function ThemeSwitcher:Init(Window, ScreenGui, ExistingTab)
    assert(Window, "[ThemeSwitcher] Window is nil — pass your Window table")
    assert(ScreenGui, "[ThemeSwitcher] ScreenGui is nil — pass your ScreenGui")

    local currentThemeName = LoadTheme()
    local currentTheme     = Themes[currentThemeName]

    -- Apply saved theme immediately on load
    task.defer(function()
        ApplyTheme(ScreenGui, currentTheme)
    end)

    -- Build list of theme names for the dropdown
    local themeNames = {}
    for k in pairs(Themes) do
        table.insert(themeNames, k)
    end
    table.sort(themeNames)

    -- Create or use provided tab
    local Tab = ExistingTab or Window:NewTab({
        Title       = "Theme",
        Description = "Customise UI colours",
        Icon        = "rbxassetid://7733964640",
    })

    local Section = Tab:NewSection({
        Title = "Theme Selector",
        Side  = "Left",
    })

    -- ── Theme dropdown ────────────────────────────────────────────────────
    Section:NewDropdown({
        Title   = "Colour Theme",
        Default = currentThemeName,
        Values  = themeNames,
        Callback = function(selected)
            local theme = Themes[selected]
            if not theme then return end
            currentThemeName = selected
            currentTheme     = theme
            ApplyTheme(ScreenGui, theme)
            SaveTheme(selected)
        end,
    })

    -- ── Individual accent colour picker (if your library supports it) ────
    -- Wrapped in pcall so it silently skips if NewColorpicker doesn't exist
    pcall(function()
        Section:NewColorpicker({
            Title   = "Custom Accent",
            Default = currentTheme.accent,
            Callback = function(color)
                -- Only override the accent; keep other theme colours
                currentTheme = {
                    bg      = currentTheme.bg,
                    panel   = currentTheme.panel,
                    accent  = color,
                    text    = currentTheme.text,
                    subtext = currentTheme.subtext,
                    element = currentTheme.element,
                    stroke  = currentTheme.stroke,
                    shadow  = currentTheme.shadow,
                }
                -- Re-apply with new accent
                ApplyTheme(ScreenGui, currentTheme)
            end,
        })
    end)

    -- ── Preview button: cycle through themes ──────────────────────────────
    local previewIndex = 1
    Section:NewButton({
        Title    = "Preview Next Theme",
        Callback = function()
            previewIndex = (previewIndex % #themeNames) + 1
            local name  = themeNames[previewIndex]
            local theme = Themes[name]
            ApplyTheme(ScreenGui, theme)
            -- Don't save — just preview. User must select from dropdown to save.
        end,
    })

    -- ── Reset to default ──────────────────────────────────────────────────
    Section:NewButton({
        Title    = "Reset to Koeru",
        Callback = function()
            ApplyTheme(ScreenGui, Themes["Koeru"])
            SaveTheme("Koeru")
        end,
    })

    -- ── Right column: theme info ──────────────────────────────────────────
    local InfoSection = Tab:NewSection({
        Title = "Theme Info",
        Side  = "Right",
    })

    local ThemeLabel = InfoSection:NewTitle("Active: " .. currentThemeName)

    -- Update label when theme changes
    local _orig = Themes
    -- Patch: wrap the dropdown callback to also update the label
    -- (we do this via a simple RenderStep poll since we can't hook callbacks after creation)
    task.spawn(function()
        local last = currentThemeName
        while task.wait(0.5) do
            if currentThemeName ~= last then
                last = currentThemeName
                pcall(function()
                    ThemeLabel:Set("Active: " .. currentThemeName)
                end)
            end
        end
    end)

    -- Expose API in case script wants to change theme programmatically
    self.SetTheme = function(_, name)
        local theme = Themes[name]
        if not theme then
            warn("[ThemeSwitcher] Unknown theme: " .. tostring(name))
            return
        end
        currentThemeName = name
        currentTheme     = theme
        ApplyTheme(ScreenGui, theme)
        SaveTheme(name)
    end

    self.GetTheme = function()
        return currentThemeName, currentTheme
    end

    self.AddTheme = function(_, name, themeData)
        assert(type(name) == "string",      "[ThemeSwitcher] theme name must be a string")
        assert(type(themeData) == "table",  "[ThemeSwitcher] themeData must be a table")
        Themes[name] = themeData
    end

    return self
end

return ThemeSwitcher
