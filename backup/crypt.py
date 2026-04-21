def crypt(s):
    return "".join(chr(ord(c) + 1) for c in s)

strings = [
    "Aimbot", "Enable", "Silent Aim", "Aim Method", "Aim Style", "Mouse", "Camera", "Linear", "Exponential",
    "Targeting Mode", "Closest to Crosshair", "Distance", "Target Hitboxes", "Head", "Torso", "Random", "Checks", "Visible Only", "None", "Sticky Aim",
    "Triggerbot", "Delay", "Click Duration (ms)", "Hitchance", "Max Distance", "Prediction", "Hitboxes", "Both",
    "ESP", "Enable ESP", "Skeleton ESP", "Crimson Chams", "Offscreen Arrows", "Bullet Tracers", "Midnight Mode",
    "Spectate", "Select Player", "Enable Spectate", "Spec", "Teleport",
    "Misc", "Fly", "Fly Method", "Velocity", "CFrame", "Fly Speed", "Orbit Target", "Orbit Radius", "Orbit Speed", 
    "Speed", "Speed Method", "Speed Value", "Walkspeed", "Value", "Jumppower", "Anti Afk", "Void Spam", "Void Speed",
    "Settings", "Stream Proof", "Menu Key", "Unload Client",
    "PRIVATE ACCESS", "Enter Key...", "Login", "Welcome ", "Invalid Key!", "vin", "vivid", "Welcome Owner"
]
for s in strings:
    print(f'-- {s} -> {crypt(s)}')
