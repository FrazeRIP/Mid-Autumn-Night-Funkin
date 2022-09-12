package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.input.mouse.FlxMouse;

class ColleMember extends FlxSprite 
{

    public var name:String;
    public var canUnlock:Bool=true;
    public var unlocked:Bool=false;

    public var selected:Bool=false;

    public var lockedText:String;
    public var unlockedText:String;

    public var positionX:Int;
    public var positionY:Int;

    public override function new(x:Int,y:Int,Name:String,lockedtext:String,unlockedtext:String,canunlock:Bool=true,PositionX:Int,PositionY:Int):Void
    {
        super(x,y);
        this.name=Name;
        this.frames= Paths.getSparrowAtlas('collectionstate/TokenS/'+Name+"TokenS",'mid-autumn');
        this.animation.addByPrefix("Locked","Locked0",24,true);
        this.animation.addByPrefix("LockSelected","LockedSelected0",24,true);
        if(canunlock)
        {
        this.animation.addByPrefix("Normal","Normal0",24,true);
        this.animation.addByPrefix("NormalSelected","NormalSelected0",24,true);
        }

        canUnlock=canunlock;
        lockedText=lockedtext;
        unlockedText=unlockedtext;
        positionX=PositionX;
        positionY=PositionY;

        FlxMouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut);
    }
    public function stopEvnet()
    {
        FlxMouseEventManager.setObjectMouseEnabled(this,false);
    }
    public function startEvnet()
    {
        FlxMouseEventManager.setObjectMouseEnabled(this,true);
    }

    function onMouseDown(_)
    {
        if(this.unlocked)
        CollectionState.mouseClicked=true;
    }
   function onMouseOver(_)
    {
        CollectionState.mouseControl=true;
        if(unlocked)
        {
            selected=true;
            this.animation.play("NormalSelected");
            CollectionState.textCache=this.unlockedText;
        }
        else
        {
            selected=true;
            this.animation.play("LockSelected");
            CollectionState.textCache=this.lockedText;
        }
        CollectionState.memberX=this.positionX;
        CollectionState.memberY=this.positionY;
        CollectionState.tokenLargeName=this.name;
    
    }
    function onMouseOut(_)
    {
        CollectionState.mouseControl=false;
        CollectionState.mouseClicked=false;
        if(unlocked)
            {
                selected=false;
                this.animation.play("Normal");
            }
            else
            {
                selected=false;
                this.animation.play("Locked");
            }
    }
}