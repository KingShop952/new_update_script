-- Load thư viện UI
local RimusLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Duc18-code/scriptducv3/refs/heads/main/UInew.lua"))()

-- Hiển thị thông báo tải thành công
local Notify = RimusLib:MakeNotify({
    Title = "Thông Báo",
    Content = "Đã tải xong giao diện!",
    Image = "rbxassetid://100756646036568",
    Time = 1,
    Delay = 5
})

-- Tạo UI chính
local RimusHub = RimusLib:MakeGui({
    NameHub = "PhatDepZai Hub",
    NameGam = "     [Main]",
    Icon = "rbxassetid://100756646036568"
})

----------------------------------------
-- Tab: Main
----------------------------------------
local TabMain = RimusHub:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://100756646036568"
})

-- Auto Farm Level (Chưa có)
TabMain:AddLabel({
    Title = "Auto Farm Level: Will coming soon!",
    Icon = "rbxassetid://100756646036568"
})

-- Auto Bone
TabMain:AddToggle({
    Title = "Auto Bone",
    Default = false,
    Callback = function(value)
        if value then
            print("Auto Bone: Bật")
            -- Thêm code Auto Bone ở đây
        else
            print("Auto Bone: Tắt")
        end
    end
})

-- Auto Kata
TabMain:AddToggle({
    Title = "Auto Kata",
    Default = false,
    Callback = function(value)
        if value then
            print("Auto Kata: Bật")
            -- Thêm code Auto Kata ở đây
        else
            print("Auto Kata: Tắt")
        end
    end
})

----------------------------------------
-- Tab: Setting Farm
----------------------------------------
local TabSetting = RimusHub:CreateTab({
    Name = "Setting Farm",
    Icon = "rbxassetid://100756646036568"
})

-- Fast Attack
TabSetting:AddToggle({
    Title = "Fast Attack",
    Default = false,
    Callback = function(value)
        if value then
            print("Fast Attack: Bật")
            -- Thêm code Fast Attack ở đây
        else
            print("Fast Attack: Tắt")
        end
    end
})

-- Bring Mob
TabSetting:AddToggle({
    Title = "Bring Mob",
    Default = false,
    Callback = function(value)
        if value then
            print("Bring Mob: Bật")
            -- Thêm code Bring Mob ở đây
        else
            print("Bring Mob: Tắt")
        end
    end
})

-- Speed Tween (Chưa có)
TabSetting:AddLabel({
    Title = "Speed Tween: Will coming soon!",
    Icon = "rbxassetid://100756646036568"
})

-- Use Portal Teleport (Chưa có)
TabSetting:AddLabel({
    Title = "Use Portal Teleport: Will coming soon!",
    Icon = "rbxassetid://100756646036568"
})

----------------------------------------
-- Tab: Race V4
----------------------------------------
local TabRaceV4 = RimusHub:CreateTab({
    Name = "Race v4",
    Icon = "rbxassetid://100756646036568"
})

-- Kill Player After Trial
TabRaceV4:AddToggle({
    Title = "Kill Player After Trial",
    Default = false,
    Callback = function(value)
        if value then
            print("Kill Player After Trial: Bật")
            -- Thêm code Kill Player ở đây
        else
            print("Kill Player After Trial: Tắt")
        end
    end
})

-- Auto Finish Trial
TabRaceV4:AddToggle({
    Title = "Auto Finish Trial",
    Default = false,
    Callback = function(value)
        if value then
            print("Auto Finish Trial: Bật")
            -- Thêm code Auto Finish Trial ở đây
        else
            print("Auto Finish Trial: Tắt")
        end
    end
})
