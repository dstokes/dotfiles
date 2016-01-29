--
-- Activiate lockscreen if a Yubikey is removed without
-- the command modifier pressed.
--
local usbw = nil

function usbCallback(data)
  if string.match(data["productName"], "Yubikey") then
    if (data["eventType"] == "removed") then
      -- make sure cmd
      if (hs.eventtap.checkKeyboardModifiers()["cmd"] == nil) then
        hs.caffeinate.lockScreen()
      end
    end
  end
end

usbw = hs.usb.watcher.new(usbCallback)
usbw:start()
