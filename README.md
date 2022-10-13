# Localization
Brightscript Scenegraph Channel to help developers in localization integration to Roku Channels.

# Integration Steps
    1. Create 'locale' folder (if its not there).
    2. Inside locale folder create sub folders for different-2 locales.
    3. Inside sub folder (let say en_US) create 'images' folder and put respective image inside that.
    4. Direct to the sub folder put a file with name translation.xml
    5. Inside translation.xml, put the following code
        
        <?xml version="1.0" encoding="UTF-8"?>
            <xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
	        <file source-language="en-US" target-language="de-DE">
		
                <body>

			        <trans-unit id="0">
				        <source>Hello</source>
				        <target>Hallo
				        </target>
			        </trans-unit>

			        <trans-unit id="1">
				        <source>How are you?</source>
				        <target>Hoe is het met je?
				        </target>
			        </trans-unit>
		        </body>
	        </file>
            </xliff>

6. In the above code <source> contains the original string and </target> contains the converted string

# How to access the converted string in Brightscript file.
    Use Brightscript global function Tr("source string") to get the converted string. For example: 
    
    m.label1.text = Tr("Hello")

# How to access the locale specific images from respective folder

    localize = createObject("RoLocalization") 
    m.flagIcon.uri = localize.GetLocalizedAsset("images", "flag.png") 'Here flag.png is saved 'images' folder

# For any further help, feel free raise the issue here or connect at
    
    Website: www.jhnvi.com
    Email: shishupal.shakya@jhnvi.com
