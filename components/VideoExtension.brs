sub initiateLiveVideo()
    content = createObject("roSGNode", "ContentNode")
    content.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    content.streamFormat = "mp4"
    content.title = "Sample Video"
    m.videoPlayer.content = content
    m.videoPlayer.control = "play"
    m.videoPlayer.setFocus(true)
end sub   