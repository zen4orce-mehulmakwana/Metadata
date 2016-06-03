trigger dsfsd on Account (before insert) 
{
	System.debug('hi');
    ToolingAPIWSDL.ActionOverride obj = new ToolingAPIWSDL.ActionOverride();
}