package;

import haxe.Timer;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxEase.EaseFunction;
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
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;


class PuzzleMember extends FlxSpriteGroup
{
    public var memberText:FlxText;
    public var isAnswer:Bool;
    public var bgSprite:FlxSprite;

    public override function new(word:String,x:Float,y:Float) {
        super();

        // FlxG.plugins.add(new FlxMouseEventManager());

        this.memberText=new FlxText(5,0,0,word,34);
        this.width=50;
        this.height=50;
        this.x=x;
        this.y=y;
        memberText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",memberText.size);
        memberText.color=0xFF000000;

        bgSprite=new FlxSprite(0,0).makeGraphic(50,50,0xFFFFFFFF);
        bgSprite.alpha=0.1;

        add(bgSprite);
        add(memberText);

        FlxMouseEventManager.add(this, onMouseDown, null, onMouseOver, onMouseOut);
    }

    override function update(elapsed:Float)
        {
            super.update(elapsed);
    
            // if (sprTracker != null)
            //     memberText.setPosition(0,0);
            if(PuzzleSubState.seletedAnswer)
            {
                memberText.color=0xff000000;
                stopEvnet();
            }
            
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
        var ROWToken:FlxSprite=new FlxSprite();
        ROWToken.frames=Paths.getSparrowAtlas('storystate/puzzle/OX','mid-autumn');
        ROWToken.animation.addByPrefix("right",'OX O0000',24,false);
        ROWToken.animation.addByPrefix("wrong",'OX X0000',24,false);
        if(isAnswer)
        {
            ROWToken.animation.play("right");
            add(ROWToken);
            FlxG.sound.play(Paths.sound('storystate/correct','mid-autumn'));
            PuzzleSubState.seletedAnswer=true;
            new FlxTimer().start(1.0,function(tmr:FlxTimer){ 
                FlxTween.tween(ROWToken,{alpha:0},1,{onComplete:function(twn:FlxTween) {
                remove(ROWToken);
                }});});
        }
        else 
        {
            ROWToken.animation.play("wrong");
            add(ROWToken);
            FlxG.sound.play(Paths.sound('storystate/error','mid-autumn'));
            new FlxTimer().start(1.0,function(tmr:FlxTimer){ 
            FlxTween.tween(ROWToken,{alpha:0},1,{onComplete:function(twn:FlxTween) {
            remove(ROWToken);
            }});});
        }
    }

    function onMouseOver(_)
    {
        memberText.color=0xFFBA7F48;
    }

    function onMouseOut(_)
    {
        memberText.color=0xFF000000;
    }
    override function destroy() {
        PuzzleSubState.seletedAnswer=false;
        startEvnet();
        super.destroy();
    }
}