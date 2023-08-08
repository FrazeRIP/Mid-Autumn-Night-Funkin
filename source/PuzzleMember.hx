package;

import flixel.text.FlxText;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.input.mouse.FlxMouse;
import flixel.group.FlxSpriteGroup;


class PuzzleMember extends FlxSpriteGroup
{
    public var memberText:FlxText;
    public var isAnswer:Bool;
    public var bgSprite:FlxSprite;
    
    public override function new(word:String,x:Float,y:Float) {
        super();

        this.memberText=new FlxText(0,0,0,word,24);
        this.width=30;
        this.height=30;
        this.x=x;
        this.y=y;
        memberText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",memberText.size);
        memberText.color=0x000000;

        bgSprite=new FlxSprite(0,0).makeGraphic(30,30);

        add(bgSprite);
        add(memberText);

        FlxMouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut);
    }

    override function update(elapsed:Float)
        {
            super.update(elapsed);
    
            // if (sprTracker != null)
            //     memberText.setPosition(0,0);

            
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

    }
    function onMouseOver(_)
    {
        
    }
    function onMouseOut(_)
    {

    }
}