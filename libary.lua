local Library = {}
local TweenService = game:GetService("TweenService")

-- Constants for icons
local ICONS = {
    CHECKMARK = "rbxassetid://111013677258191",
    SKULL = "rbxassetid://98211633595839",
    VISUALS = "rbxassetid://81942414395302",
    EXPLOITS = "rbxassetid://136110366778198",
    SETTINGS = "rbxassetid://93213086069603"
}

-- UI Colors
local Colors = {
    Background = Color3.fromRGB(25, 25, 35),
    Accent = Color3.fromRGB(45, 45, 55),
    Text = Color3.fromRGB(255, 255, 255),
    Highlight = Color3.fromRGB(70, 70, 255),
    Success = Color3.fromRGB(46, 204, 113),
    Error = Color3.fromRGB(231, 76, 60),
    Warning = Color3.fromRGB(241, 196, 15)
}

-- Animation Settings
local AnimationSettings = {
    Time = 0.3,
    EasingStyle = Enum.EasingStyle.Quad,
    EasingDirection = Enum.EasingDirection.Out
}

-- Notification System
function Library:CreateNotification(title, message, type)
    local NotificationGui = Instance.new("ScreenGui")
    local NotificationFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local IconFrame = Instance.new("ImageLabel")
    local TitleLabel = Instance.new("TextLabel")
    local MessageLabel = Instance.new("TextLabel")
    local ProgressBar = Instance.new("Frame")
    
    NotificationGui.Parent = game:GetService("CoreGui")
    
    NotificationFrame.Name = "NotificationFrame"
    NotificationFrame.Parent = NotificationGui
    NotificationFrame.BackgroundColor3 = Colors.Background
    NotificationFrame.Position = UDim2.new(1, 20, 0.8, 0)
    NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
    
    UICorner.Parent = NotificationFrame
    UICorner.CornerRadius = UDim.new(0, 8)
    
    IconFrame.Name = "IconFrame"
    IconFrame.Parent = NotificationFrame
    IconFrame.BackgroundTransparency = 1
    IconFrame.Position = UDim2.new(0, 10, 0, 10)
    IconFrame.Size = UDim2.new(0, 24, 0, 24)
    IconFrame.Image = ICONS.CHECKMARK
    IconFrame.ImageColor3 = type == "success" and Colors.Success or 
                          type == "error" and Colors.Error or 
                          Colors.Warning
    
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = NotificationFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 44, 0, 10)
    TitleLabel.Size = UDim2.new(1, -54, 0, 20)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Colors.Text
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    MessageLabel.Name = "MessageLabel"
    MessageLabel.Parent = NotificationFrame
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Position = UDim2.new(0, 44, 0, 35)
    MessageLabel.Size = UDim2.new(1, -54, 0, 35)
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.Text = message
    MessageLabel.TextColor3 = Colors.Text
    MessageLabel.TextSize = 12
    MessageLabel.TextWrapped = true
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Parent = NotificationFrame
    ProgressBar.BackgroundColor3 = type == "success" and Colors.Success or 
                                 type == "error" and Colors.Error or 
                                 Colors.Warning
    ProgressBar.Position = UDim2.new(0, 0, 1, -2)
    ProgressBar.Size = UDim2.new(1, 0, 0, 2)
    
    -- Animate in
    local tweenInfo = TweenInfo.new(
        AnimationSettings.Time,
        AnimationSettings.EasingStyle,
        AnimationSettings.EasingDirection
    )
    
    local positionTween = TweenService:Create(
        NotificationFrame,
        tweenInfo,
        {Position = UDim2.new(1, -320, 0.8, 0)}
    )
    
    positionTween:Play()
    
    -- Progress bar animation
    local progressTween = TweenService:Create(
        ProgressBar,
        TweenInfo.new(3),
        {Size = UDim2.new(0, 0, 0, 2)}
    )
    
    progressTween:Play()
    
    -- Remove notification after delay
    task.delay(3, function()
        local fadeOut = TweenService:Create(
            NotificationFrame,
            tweenInfo,
            {Position = UDim2.new(1, 20, 0.8, 0)}
        )
        fadeOut:Play()
        fadeOut.Completed:Wait()
        NotificationGui:Destroy()
    end)
end

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Sidebar = Instance.new("Frame")
    local IconList = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local Content = Instance.new("Frame")

    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Colors.Background
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.ClipsDescendants = true
    Main.Active = true
    Main.Draggable = true

    -- Initial animation state
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.BackgroundTransparency = 1

    UICorner.Parent = Main
    UICorner.CornerRadius = UDim.new(0, 8)

    -- Animate window opening
    local tweenInfo = TweenInfo.new(
        AnimationSettings.Time,
        AnimationSettings.EasingStyle,
        AnimationSettings.EasingDirection
    )

    local sizeTween = TweenService:Create(
        Main,
        tweenInfo,
        {
            Size = UDim2.new(0, 500, 0, 350),
            BackgroundTransparency = 0
        }
    )

    sizeTween:Play()

    -- Set up sidebar
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = Colors.Accent
    Sidebar.Position = UDim2.new(0, 0, 0, 0)
    Sidebar.Size = UDim2.new(0, 50, 1, 0)

    IconList.Name = "IconList"
    IconList.Parent = Sidebar
    IconList.BackgroundTransparency = 1
    IconList.Position = UDim2.new(0, 0, 0, 10)
    IconList.Size = UDim2.new(1, 0, 1, -20)

    UIListLayout.Parent = IconList
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    -- Set up content area
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0, 60, 0, 10)
    Content.Size = UDim2.new(1, -70, 1, -20)

    -- Add close button
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = Main
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -30, 0, 10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Image = "rbxassetid://6035047409"
    CloseButton.ImageColor3 = Colors.Text

    CloseButton.MouseButton1Click:Connect(function()
        -- Animate window closing
        local closeTween = TweenService:Create(
            Main,
            tweenInfo,
            {
                Size = UDim2.new(0, 0, 0, 0),
                BackgroundTransparency = 1
            }
        )
        
        closeTween:Play()
        closeTween.Completed:Wait()
        ScreenGui:Destroy()
    end)

    local Window = {}
    
    -- Add notification method to window
    function Window:Notify(title, message, type)
        Library:CreateNotification(title, message, type)
    end

    -- Add tab functionality
    function Window:AddTab(icon, name)
        local TabButton = Instance.new("ImageButton")
        local TabContent = Instance.new("Frame")
        
        -- Set up tab button
        TabButton.Name = name .. "Tab"
        TabButton.Parent = IconList
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(0, 30, 0, 30)
        TabButton.Image = icon
        TabButton.ImageColor3 = Colors.Text
        
        -- Set up tab content
        TabContent.Name = name .. "Content"
        TabContent.Parent = Content
        TabContent.BackgroundTransparency = 1
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Visible = false
        
        local Tab = {}
        
        function Tab:AddToggle(text, callback)
            local Toggle = Instance.new("Frame")
            local ToggleButton = Instance.new("ImageButton")
            local ToggleText = Instance.new("TextLabel")
            
            Toggle.Name = "Toggle"
            Toggle.Parent = TabContent
            Toggle.BackgroundTransparency = 1
            Toggle.Size = UDim2.new(1, 0, 0, 30)
            
            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = Toggle
            ToggleButton.BackgroundColor3 = Colors.Accent
            ToggleButton.Size = UDim2.new(0, 20, 0, 20)
            ToggleButton.Position = UDim2.new(0, 5, 0.5, -10)
            ToggleButton.Image = ICONS.CHECKMARK
            ToggleButton.ImageTransparency = 1
            
            ToggleText.Name = "ToggleText"
            ToggleText.Parent = Toggle
            ToggleText.BackgroundTransparency = 1
            ToggleText.Position = UDim2.new(0, 35, 0, 0)
            ToggleText.Size = UDim2.new(1, -35, 1, 0)
            ToggleText.Font = Enum.Font.GothamSemibold
            ToggleText.Text = text
            ToggleText.TextColor3 = Colors.Text
            ToggleText.TextSize = 14
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left
            
            local enabled = false
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                ToggleButton.ImageTransparency = enabled and 0 or 1
                if callback then callback(enabled) end
            end)
        end
        
        function Tab:AddSlider(text, min, max, default, callback)
            local Slider = Instance.new("Frame")
            local SliderText = Instance.new("TextLabel")
            local SliderBar = Instance.new("Frame")
            local SliderFill = Instance.new("Frame")
            local SliderValue = Instance.new("TextLabel")
            
            Slider.Name = "Slider"
            Slider.Parent = TabContent
            Slider.BackgroundTransparency = 1
            Slider.Size = UDim2.new(1, 0, 0, 30)
            
            SliderText.Name = "SliderText"
            SliderText.Parent = Slider
            SliderText.BackgroundTransparency = 1
            SliderText.Position = UDim2.new(0, 5, 0, 0)
            SliderText.Size = UDim2.new(0, 100, 1, 0)
            SliderText.Font = Enum.Font.GothamSemibold
            SliderText.Text = text
            SliderText.TextColor3 = Colors.Text
            SliderText.TextSize = 14
            SliderText.TextXAlignment = Enum.TextXAlignment.Left
            
            SliderBar.Name = "SliderBar"
            SliderBar.Parent = Slider
            SliderBar.BackgroundColor3 = Colors.Accent
            SliderBar.Position = UDim2.new(0, 110, 0.5, -5)
            SliderBar.Size = UDim2.new(0, 200, 0, 10)
            
            SliderFill.Name = "SliderFill"
            SliderFill.Parent = SliderBar
            SliderFill.BackgroundColor3 = Colors.Highlight
            SliderFill.Size = UDim2.new(0, 0, 1, 0)
            
            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundTransparency = 1
            SliderValue.Position = UDim2.new(0, 315, 0, 0)
            SliderValue.Size = UDim2.new(0, 50, 1, 0)
            SliderValue.Font = Enum.Font.GothamSemibold
            SliderValue.Text = tostring(default)
            SliderValue.TextColor3 = Colors.Text
            SliderValue.TextSize = 14
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right
            
            local value = default
            local dragging = false
            
            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)
            
            SliderBar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                    local mousePosition = input.Position
                    local sliderPosition = SliderBar.AbsolutePosition
                    local sliderSize = SliderBar.AbsoluteSize
                    local fillSize = math.clamp((mousePosition.X - sliderPosition.X) / sliderSize.X, 0, 1)
                    SliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
                    value = math.floor((fillSize * (max - min)) + min)
                    SliderValue.Text = tostring(value)
                    if callback then callback(value) end
                end
            end)
        end
        
        return Tab
    end
    
    return Window
end

return Library
