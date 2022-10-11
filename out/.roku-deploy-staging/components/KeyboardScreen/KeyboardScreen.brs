' ********** Copyright 2016 Roku Corp.  All Rights Reserved. **********  

sub init()
    m.top.SetFocus(true)
    m.searchkeyboard = m.top.findNode("searchkeyboard")
    m.tempLabel = m.top.findNode("tempLabel")
End sub

sub configureKeyboard()
    m.searchkeyboard.textEditBox.maxTextLength = 50
    m.searchkeyboard.domain = "generic" 'This could be email, numeric, alphanumeric, generic, alphanumeric & password
    m.searchkeyboard.textEditBox.voiceEntryType = "generic"
    m.searchkeyboard.textEditBox.voiceEnabled = true
    m.searchkeyboard.setFocus(true)
    m.searchkeyboard.textEditBox.observeField("text", "populateLabel")
end sub

sub populateLabel()
    if m.searchkeyboard.domain = "generic"
        m.tempLabel.text = m.tempLabel.text + " " + m.searchkeyboard.textEditBox.text 
    else
        m.tempLabel.text = m.searchkeyboard.textEditBox.text
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    if press
        if key = "back"
            m.top.removeKeyboardScreen = true
            result = true
        end if
    end if
    return result 
end function
