
' ----------------------------------------------------------------
REM : This method creates Input Object
' ----------------------------------------------------------------
sub createInputVoiceTask()
    if (m.InputTask = invalid)
        m.InputTask = m.top.createChild("inputTask")
    end if
    m.InputTask.control = "RUN"
  end sub
  
    ' ----------------------------------------------------------------
  REM : This method gets triggerred when voice command data is received by channel
  ' ----------------------------------------------------------------
    sub onVoiceCommandsDataReceived()
        inputData = m.top.voiceCommandsData
        ? "*** inputData *****";inputData
        handleVoiceCommands(inputData)
    end sub

    ' ----------------------------------------------------------------
REM : This method handles voice commands
' ----------------------------------------------------------------
sub handleVoiceCommands(inputData as Object)
    evt = inputData
    ret = "unhandled"
    cmd = evt.command
        if cmd = "play" or cmd = "resume"
            ret = handlePlayVoiceCommand()

        else if cmd = "nowplaying"
            ret = handleNowPlayingCommand()

        else if cmd = "pause" or cmd = "stop" ' if seeking then play else pause
            ret = handlePauseVoiceCommand()
            
        else if cmd = "forward"
            ret = handleForwardRewindCommands("forward")

        else if cmd = "shuffle"
            ret = "error.channel"    

        else if cmd = "rewind"
            ret = handleForwardRewindCommands("rewind")
            
        else if cmd = "startover"
            ret = seekVideoToPosistion()

        else if cmd = "like" Or cmd = "dislike"
            ret = "error.channel" 
        end if
    m.top.getScene().voiceCommandStatus = ret
end sub

' ----------------------------------------------------------------
REM : This method handles Play/Resume voice commands
' ----------------------------------------------------------------
sub handlePlayVoiceCommand() as String
    ret = "unhandled"
    if (getVideoState() = "paused") Or (getVideoState() = "stopped")
        m.videoPlayer.control = "resume"
        ret = "success"
        
    else if (getVideoState() = "playing")
        ret = "error.redundant" ' already playing
    end if
    return ret
end sub

' ----------------------------------------------------------------
REM : This method handles NowPlaying voice command
' ----------------------------------------------------------------
sub handleNowPlayingCommand() as String
    ret = "unhandled"
    if m.videoPlayer <> invalid And m.videoPlayer.content <> invalid And m.videoPlayer.content.title <> invalid And m.videoPlayer.content.title.len() <> 0  
        ret = "success"
    else 
        ret = "error.generic"
    end if
    return ret
end sub

' ----------------------------------------------------------------
REM : This method handles Pause/Stop voice commands
' ----------------------------------------------------------------
sub handlePauseVoiceCommand() as String
    ret = "unhandled"
    if (getVideoState() = "playing")
        ret = "success"
        m.videoPlayer.control = "pause"
    else if (getVideoState() = "paused") Or (getVideoState() = "stopped")  
        ret = "error.redundant"  ' already paused
    end if
    return ret
end sub

' ----------------------------------------------------------------
REM : This method handles Forward/Rewind/Replay voice commands
' ----------------------------------------------------------------
sub handleForwardRewindCommands(command as String) as String
    ret = "success"
    position = m.videoPlayer.position
    if command = "forward"
        position = position + 5
    else
        position = position - 5    
    end if
    m.videoPlayer.seek = position
    return ret
end sub

' ----------------------------------------------------------------
REM : This method handles StartOver voice commands
' ----------------------------------------------------------------
sub seekVideoToPosistion() as String
    ret = "success"
    m.videoPlayer.seek = 0
    return ret
end sub

function getVideoState()
    if m.videoPlayer = invalid
        return "videoIsInvalid"
    end if
    return m.videoPlayer.state
end function
  