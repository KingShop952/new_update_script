--[ file code được viết bởi duc design : 0765520260 mua file thì ib ]--

local RimusLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Duc18-code/scriptducv3/refs/heads/main/UInew.lua"))()
local Notify = RimusLib:MakeNotify({
    Title = "Notification",
    Content = "Anh Phát Bỏ Con",
    Image = "rbxassetid://100756646036568",
    Time = 1,
    Delay = 5
})

local RimusHub = RimusLib:MakeGui({
    NameHub = "PhatDepZai Hub",
    NameGam = "     [Chat]",
    Icon = "rbxassetid://100756646036568"
})

local Tab1 = RimusHub:CreateTab({
    Name = "Tab Chat",
    Icon = "rbxassetid://100756646036568"
})

-- Mục Spam Chat Đã Được Tao Bố Trí Thêm
local spamText = "" -- Lưu trữ câu chat ở đây
local isSpamming = false -- Biến kiểm tra xem có đang spam không 
local delayTime = 0 -- Mặc định là 0, tức là không có thời gian chờ (spam liên tục)

-- Khung nhập văn bản
local Input = Tab1:AddInput({
    Title = "Nhập câu chat",
    Icon = "rbxassetid://100756646036568",
    Callback = function(Value)
        spamText = Value -- Lưu trữ câu chat khi người dùng nhập
        print("Câu chat đã nhập: " .. spamText)
    end
})

-- Mục lựa chọn để chỉnh thời gian chờ chúng mày có thể thêm vào
local Dropdown = Tab1:AddDropdown({
    Title = "Chọn thời gian chờ",
    Multi = false,
    Options = {"1 phút", "5 phút", "Spam liên tục"},
    Default = "Spam liên tục", -- Mặc định là không có thời gian chờ
    Callback = function(Value)
        if Value == "1 phút" then
            delayTime = 60 -- 1 phút = 60 giây
        elseif Value == "5 phút" then
            delayTime = 300 -- 5 phút = 300 giây
        else
            delayTime = 0 -- Spam liên tục ( mặc định khi mày không chọn gì )
        end
        print("Thời gian chờ được thiết lập: " .. (delayTime == 0 and "Spam liên tục" or delayTime .. " giây"))
    end
})

-- Đây Là Nút Start để bắt đầu spam
local Button = Tab1:AddButton({
    Title = "Start Spam Chat",
    Content = "Bắt đầu spam",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        if spamText ~= "" then
            isSpamming = true
            print("Bắt đầu spam: " .. spamText)
            
            -- Sử dụng coroutine để tạo vòng lặp không chặn luồng chính
            coroutine.wrap(function()
                while isSpamming do
                    -- Gửi câu chat
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(spamText, "All")
                    
                    if delayTime > 0 then
                        wait(delayTime) -- Sử dụng thời gian chờ đã thiết lập
                    else
                        wait(0) -- Spam liên tục (không chờ)
                    end
                end
            end)()
        else
            Notify.Content = "Vui lòng nhập câu chat"
            Notify.Time = 2
            Notify.Delay = 5
            Notify:Send()
        end
    end
})

-- Nút Stop để dừng spam
local StopButton = Tab1:AddButton({
    Title = "Stop Spam Chat",
    Content = "Dừng spam",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        isSpamming = false
        print("Đã dừng spam")
    end
})

-- Đây là tab FPS đã được tao tối ưu mượt mà 
local TabFPS = RimusHub:CreateTab({
    Name = "Tab Giảm Lag",
    Icon = "rbxassetid://100756646036568"
})

-- Mục Giảm FPS nek
local ReduceFPSButton = TabFPS:AddButton({
    Title = "Giảm FPS",
    Content = "Tối ưu hóa FPS bằng cách xóa hoạt ảnh và làm mờ màu",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        -- Xóa hoạt ảnh và làm mờ màu trong game hạn chế bị kick
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic -- Chuyển tất cả vật liệu thành SmoothPlastic
                v.Color = Color3.new(0.5, 0.5, 0.5) -- Làm mờ màu bằng cách đổi tất cả màu về xám
                v.CastShadow = false -- Tắt bóng đổ
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v:Destroy() -- Xóa các hoạt ảnh như Particle, Trail, Beam
            end
        end
        -- Tắt hiệu ứng ánh sáng không cần thiết
        if game.Lighting:FindFirstChild("ColorCorrection") then
            game.Lighting.ColorCorrection:Destroy()
        end
        if game.Lighting:FindFirstChild("Bloom") then
            game.Lighting.Bloom:Destroy()
        end
        print("FPS đã được tối ưu")
    end
})

-- Mục Server Hop để tìm server có ít người chơi hơn ( premium )
local ServerHopButton = TabFPS:AddButton({
    Title = "Server Hop",
    Content = "Chuyển sang server khác có ít người chơi và FPS ổn định",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        -- Hàm để tìm và tham gia server có ít người chơi hơn
        local HttpService = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local currentPlaceId = game.PlaceId
        local serversAPI = "https://games.roblox.com/v1/games/"..currentPlaceId.."/servers/Public?sortOrder=Asc&limit=100"
        
        -- Lấy danh sách server
        local function GetServerList()
            local response = HttpService:JSONDecode(game:HttpGet(serversAPI))
            return response.data
        end

        -- Tìm server có ít người
        local function HopToServer()
            local serverList = GetServerList()
            for _, server in ipairs(serverList) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    -- Tham gia server
                    TPS:TeleportToPlaceInstance(currentPlaceId, server.id, game.Players.LocalPlayer)
                    return
                end
            end
            print("Không tìm thấy server phù hợp.")
        end

        -- Gọi hàm Server Hop
        HopToServer()
    end
})

-- Mục Vô Lại Server ( rejoin server )
local ReturnToCurrentServerButton = TabFPS:AddButton({
    Title = "Vô Lại Server",
    Content = "Quay lại server hiện tại",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        -- Sử dụng TeleportService để vào lại chính server hiện tại
        local TPS = game:GetService("TeleportService")
        local currentPlaceId = game.PlaceId
        local currentServerId = game.JobId
        
        -- Tham gia lại server hiện tại
        TPS:TeleportToPlaceInstance(currentPlaceId, currentServerId, game.Players.LocalPlayer)
        print("Đang quay lại server hiện tại...")
    end
})
  
-- Tab Farming
local TabFarming = RimusHub:CreateTab({
    Name = "Tab Farming",
    Icon = "rbxassetid://100756646036568"
})

-- Auto Get CDK
TabFarming:AddButton({
    Title = "Auto Get CDK",
    Content = "Tự động lấy CDK",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        print("Đang auto lấy CDK...")
        -- Code để tự động lấy CDK
    end
})

-- Auto Troll (Sục Cu Thần Bí)
TabFarming:AddButton({
    Title = "Auto sục cu thần bí",
    Content = "Troll sục cu thần bí",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        print("Đang troll thần bí...")
        -- Code troll thần bí
    end
})

-- Auto Get SGT
TabFarming:AddButton({
    Title = "Auto Get SGT",
    Content = "Tự động lấy SGT",
    Icon = "rbxassetid://100756646036568",
    Callback = function()
        print("Đang auto lấy SGT...")
        -- Code tự động lấy SGT
    end
})

-- Fast Attack Options
local attackSpeed = "normal"

TabFarming:AddDropdown({
    Title = "Fast Attack",
    Options = {"Đánh chậm", "Đánh nhanh"},
    Default = "Đánh chậm",
    Callback = function(Value)
        attackSpeed = Value
        print("Tốc độ đánh được chọn: " .. attackSpeed)
        -- Code tùy chỉnh tốc độ đánh
    end
})
