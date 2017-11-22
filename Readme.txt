ChangeLog 0.012.00
----------------------------------------------------------------------------------------------------------------
Reminder:
	Make Certain you are using the lnk file included in the script!
	The Name is Execute_EXE.lnk

Things are now just getting interesting!

Lets start with the Major Changes.

Introducing Password Keeper!
* Password Keeper Database.
* Locks and saves when you lock your computer.
* Stores your password quickly and efficiently.
* Ctrl+C Copies your Password to the clipboard
* Ctrl+U Copies your Username to the Clipboard
* Icon Blinks if your password is getting stale / old (Only works on NON JITAccount's)

For the Ultimate Dependapotamus
* Now Introducing Spell Check.

Minor Changes
Toolbar -> Save
* The save button has been changed to save to file. To better represent what it actually does

Bug Fixes
* Threading -> Fixed a bug where you could only run one thread at a time.


Developer Notes:
----------------------------------------------------------------------------------------------------------------
Housekeeping
* Removed LIB as it is no longer needed.


Developer Notes: SDK
----------------------------------------------------------------------------------------------------------------
 * UI.Body.PWKeeper.ps1
	A Simple place to store your passwords
	Class UI_Body_PWKeeper
		Initializes the UI, Defines Timer for Notifications, Define Button Usages.
		[bool] ChangePassword()
			Changes the Password Databases Password, and saves the Database
		[bool] Save()
			Saves the Database
		[System.Object] Load()
			Loads the Database, returns XML output
		[bool] AddUser( [System.Object] PWObject )
			Adds a User to the Database based on PWObject
			Requires minimum of USERNAME
		[bool] DelUser( [System.Object] PWObject )
			Removes the PWObject from Database
	Definitions
		PWObject
			PWObject = [System.HashTable]
			Expected Elements in the table.
				[System.String] UserName
				[System.String] Password
				[System.String] AccountType
					"Jit Account", "Debug Account", "Other"
				[System.String] Description
				[System.String] Expire_Date
					"", "4 Hours", "8 Hours", "1 Day", "15 Days", "30 Days", "45 Days"
				[System.String] Expire_Enabled
					"True", "False"
				[System.String] Expire_TimeStamp
					(get-date).ToString()
	Other Notes
		Saves and Unloads the Database after you lock your computer
	Class Object also lives
		$Global:_global.LIBS.UI_Body_PWKeeper
	Template UI
		UI.Body.PWKeeper.xaml

* UI_Body_Ticket_Tech
	Class UI_Body_Ticket_Tech
		GetAll()
			Returns all updated values


ChangeLog 0.010.00
----------------------------------------------------------------------------------------------------------------
Surprise!

New version brings a flurry of changes into the environment All which you don't see.
Rebuilt the program from the ground up.
Here are the changes you do see!

The Ticket Logs!
* You can now use TAB's for your inputs, So it will look pretty when you copy and paste into it.

User Interface!
* The user interface has gotten more simplistic, and cleaner.

Development

* Developing plugins and Addons has gotten a lot more simplistic.
	Everything now is no longer limited to intimate knowledge of the environment as its all getting documented.

* Threading!


Toolkit Information
----------------------------------------------------------------------------------------------------------------
Runspace.
	Call a Runspace
	$RunSpace.NewASync($id, { script data })
Special Notes:
	While inside the runspace you will only have access to $Global:_global variable space, any local variables you want to pass back for your script will need to be placed in a safe space inside the environment.
	* Use $Global:_global.VAR_ScriptID for defining variables that you want to writeback.
		Stepping outside this can cause issues with important variables being overwritten.
	* Extremely temporary variables can be placed in $Global:_global.var
Inside the runspace in order to reach back into the environment, you will need to use the Window.Dispatcher framework.
	$Global:_global.UI.Dispatcher.Invoke({
		$Global:_global.LIBS.UI_Footer::StatusText("Adds Status Text to the bottom of the screen.")
For more information on what Commands are available please look at the Developer Notes

Developer Notes:
----------------------------------------------------------------------------------------------------------------
Loader.PS1 (New)
 * This Replaces the old loading system. For a much more clean and elegant solution.
Settings.XML (New)
* Variables are now loaded dynamically from an XML File so they can be modified on the fly
* Introducing WorkFlows
 * Workflows will now replace hard coded elements. This will help rapidly add new features.
* More Libraries to follow


Developer Notes: SDK
----------------------------------------------------------------------------------------------------------------
 * UI.Body.Ticket.Logs.ps1
	Main Module that Loads All the Ticket Log Information
	Class UI_Body_Ticket_Logs
		[string] ToOutString()
			Returns an Exportable Version of the Log
		[int] = ResetGridID([System.Collections.ArrayList] $obj)
			Returns last ID of grid count and resets ID # of value
		[System.Collections.ArrayList] = SaveData()
			Get Save Data (Does not save)
		[System.Collections.ArrayList] = LoadData([System.Collections.ArrayList] $obj)
			Loads Object into variable space
			Rebinds the elements to the screen
	Class Object also lives
		$Global:_global.LIBS.UI_Body_Ticket.Objects["UI_Body_Ticket_Logs"].lib
	Template UI
		UI.Body.Ticket.Logs.xaml

* UI.Body.Ticket.Note
	Class UI_Body_Ticket_Note
		hidden ToOutString()
			Returns $null as this data is not exportable
		[void] AddText($string)
			Adds Text to Element Text
		[string] SaveData()
			Get Save Data as Encrypted Text (Does not Save)
		[string] LoadData([string]/$null/[SecureString] $obj)
			Decrypts Data
			Rebinds Elements to the screen
	Class Object also lives
		$Global:_global.LIBS.UI_Body_Ticket.Objects["UI_Body_Ticket_Note"].lib
	Template UI
		UI.Body.Ticket.Note.xaml

* UI.Body.Ticket.Tech
	Class UI_Body_Ticket_Tech
		[string] GetSDE()
			Grabs the SDE Ticket
		Set($id, $text)
			Sets the value of $id to $text
		[string] Get($id)
			Search Display Elements for a match of $id
		[void] Refresh()
			Refresh the data inside the Grid
		[string] ToOutString()
			Returns an Exportable Version of the Log
				[System.Collections.ArrayList] = SaveData(	)
				Get Save Data (Does not save)
		[System.Collections.ArrayList] = SaveData()
			Get Save Data (Does not save)
		[System.Collections.ArrayList] = LoadData([System.Collections.ArrayList] $obj)
			Loads Object into variable space
			Rebinds the elements to the screen
	Class Object also lives
		$Global:_global.LIBS.UI_Body_Ticket.Objects["UI_Body_Ticket_Tech"].lib
	Template UI
		UI.Body.Ticket.Tech.xaml

* UI.Body.Ticket.Wiki
	Class UI_Body_Ticket_Wiki
	Todo: More!!
	Template UI
		UI.Body.Ticket.Wiki.xaml

* UI.Body.Ticket
	Class LIB_UI_Body_Ticket_Tech
		Creates Main Tabs
		Loads Controls
		[String]ToOutString()
			Returns an Exportable Version of all the elements inside the window.
		New()
			Resets all Sub Elements to default
			Calls -> LoadData($null) on all Sub Elements
		Load()
			Loads all Sub Elements from a File
			Reference to SDE
		Save()
			Gathers all the SaveData() of all the SubElements and pushes them to an XML file
			Reference SDE
	Template UI
		UI.Body.Ticket.xaml
		UI.Body.Ticket.Tab.xaml

* UI.Footer
	Class UI_Footer
		[bool]Load_Footer($xmlpath)
			Loads XML Path to User Element at Footer
		StatusText($text)
			Auto Change to StatusBar XML File
			Sets the Status to Text
		ProgressBar($text, $percent)
			Todo Finish ProgressBar
	Template UI
		UI.Footer.Status.xaml
		UI.Footer.ProgressBar.xaml
	Class Objects can be called Directly
	Class Object also lives
	$Global:_global.LIBS.UI_Footer

* UI.Nav
	Loads UI TopBar Information
	Template UI
		UI.Nav.xaml

* UI.Nav.DynTools
	Class UI_Nav.DynTools
		Upon Creation this will Load all dynamic tools and Binds all Functions
		[void]Reload()
			Reloads all Dynamic Tools in TOOLS Folder
	Template UI
		UI.Footer.Status.xaml
		UI.Footer.ProgressBar.xaml
	Class Object also lives
		$_global.LIBS.UI_Nav_DynTools
	Template UI
		UI.Nav.DynTools.xaml
	Class UI
		[System.Object]AddChild($parent, $file, $id)
			Loads $file, and inserts its window elements into $parent element location
		[System.Object]AddChild($parent, $file, $id, $childid)
			Loads $file, and inserts its window elements into $parent element location starting at $childid (of file loaded)
		[System.Object]AddItem($parent, $file, $id)
			Loads $file, and inserts its window elements into $parent element location
		[System.Object]AddItem($parent, $file, $id, $childid)
			Loads $file, and inserts its window elements into $parent element location starting at $childid (of file loaded)
		[System.Object]Add($parent,$file,$id)
			Loads $file, and replaces all sub window elements into $parent element
		[System.Object]Add($parent,$file,$id, $childID)
			Loads $file, and replaces all sub window elements into $parent element location starting at $childid (of file loaded)
		[bool]Remove([string]$id, [bool]$matchall)
			Removes $id element from Window
			Matchall is required!!
		[System.Object]Get([string]$id)
			Returns Window Element of $id
		[System.Object]Get([string]$id, [string]$childid)
			Returns Child Element from $id
		[void]ShowAll($id)
			Shows all Elements starting with the $id
		[void]HideAll($id)
			Hides all Elements starting with the $id
		NOTE: Elements stored in here are not SEARCHABLE by the window element and will need to be accessed directly
	Template UI
		UI.xaml
	Class Object also lives
		$_global.LIBS.UI

* UI.Body.Ticket.Wiki
	Class UI_Body.Ticket.Wiki
		Upon Creation this will Load all dynamic tools and Binds all Functions
	Template UI
		UI.Body.Ticket.Wiki.xaml
	Class Object also lives
		$_global.LIBS.UI_Body_Ticket.Wiki

UI.exec.ps1
	Shows Dialog of built elements

* LIB_Runspace
	Class LIB_RunSpace
		LIB_Runspace($id, $value)
			Variables $id
				$id	- Sets the Variable Name of the Shared Variables
				$value	- Variable to share with the Runspace
			This is already Initialized in $RunSpace Variable and set to $Global:_global
		[Object]NewASync($id, { <script> })
			Starts an ASyncronous Script and executes it upon creation.
			Returns Handle of the Runspace
		[void]SessionStateProxy($id, $value)
			Same Input as LIB_Runspace
			Returns Error if scripts are running
		[void]GetHandle($id)
			Returns the handle of a running script
	Class Object also lives
		$RunSpace

* UI_Toolbar
	Class UI_Toolbar
		[void]AddButton($id, $title, $description, $image, $action)
			Creates a Large button with an icon
			Note $action is a Scriptblock defined as { commands go here }
		[void]AddImage($_obj, $path)
			Adds an image to the desired object (Note works only with Grid Types)
	Template UI
		None
	Class Object also lives
		$_global.LIBS.UI_Toolbar
