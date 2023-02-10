function GM:InitPostEntity()
    if (self._PlayerLoaded) then return end
    local ply = LocalPlayer()

    net.Start('F:PC:D')
    net.SendToServer()


    self._PlayerLoaded = true
end
