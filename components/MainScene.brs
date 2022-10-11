' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********  
sub init()
    m.top.SetFocus(true)
    m.label1 = m.top.findNode("label1")
    m.label2 = m.top.findNode("label2")
    m.flagIcon = m.top.findNode("flagIcon")
    passLocalozedStrings()

    createInputVoiceTask()

    m.videoPlayer = m.top.findNode("videoPlayer")
    m.videoPlayer.translation = [40,160]
    initiateLiveVideo()
End sub

sub passLocalozedStrings()
    m.label1.text = Tr("Hello")  
    m.label2.text = Tr("How are you?")

    localize = createObject("RoLocalization") 
    m.flagIcon.uri = localize.GetLocalizedAsset("images", "flag.png")  
    m.top.SetFocus(true)
end sub

sub showKeyboardScreen()
    m.keyboardScreen = m.top.createChild("KeyboardScreen")
    m.keyboardScreen.ObserveField("removeKeyboardScreen", "onRemoveKeyboardScreen")
    m.keyboardScreen.visible = true
    m.keyboardScreen.setFocus(true)
    m.keyboardScreen.configureKeyboard = true
end sub

sub onRemoveKeyboardScreen()
    if m.keyboardScreen <> invalid
        m.top.removeChild(m.keyboardScreen)
        m.keyboardScreen = invalid
        m.top.SetFocus(true)
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        if key = "OK"
            showKeyboardScreen()
            result = true
        end if
    end if
    return result 
end function
