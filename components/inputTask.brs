sub Init()
    m.top.functionName = "listenInput"
end sub

function ListenInput()
    port = CreateObject("roMessageport")
    InputObject = CreateObject("roInput")
    InputObject.setmessageport(port)

    device = CreateObject("roDeviceInfo")
    versionInfo = device.GetOSVersion()
    versionStr = versionInfo.major + versionInfo.minor
    
    if (versionStr.ToFloat() >= "9.10".ToFloat())
        ? "[Input Control]: enabled transport Events "
        InputObject.enableTransportEvents()
    else
        return ""
    end if

    while true
        msg = port.waitmessage(100)
        if Type(msg) = "roInputEvent" then
            ? "[roInput] INPUT EVENT inside video InputControl!"
            inputData = msg.getInfo()
            ? inputData
            if inputData.DoesExist("type") and inputData.type = "transport"
                m.top.getScene().voiceCommandsData = inputData
                ? "*** inputData ****";inputData
                ? "[roInput] transport event response= "; { id: inputData.id, status: m.top.getScene().voiceCommandStatus }
                InputObject.EventResponse({ id: inputData.id, status: m.top.getScene().voiceCommandStatus })
            end if
        end if
    end while
end function