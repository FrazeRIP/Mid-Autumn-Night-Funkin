package;

import cpp.Function;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.FlxTweenManager;
import flixel.FlxObject;
import flixel.input.mouse.FlxMouse;
import CollectionMemberClass.ColleMember;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.text.FlxTypeText;
import flixel.addons.effects.FlxClothSprite;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.FlxCamera;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;

class CollectionState extends MusicBeatState
{

    public static var textCache:String="可以用鼠标操作哦！";
    public static var memberX:Int=1;
    public static var memberY:Int=1;
    public static var largeTokenSwitch:Bool=false;
    public static var targetTokenIsLocked:Bool=false;
    public static var mouseControl:Bool=false;
    public static var keyboardControl:Bool=true;
    public static var tokenLargeState:Bool=false;
    public static var isTransing:Bool=false;
    public static var mouseClicked:Bool =false;
    public static var tokenLargeName:String="Paola";

    public static var targetToken:ColleMember;

    public var bg:FlxSprite;
    public var textBar:FlxSprite;
    public var bgLight:FlxSprite;
    public var guardrail:FlxSprite;
    public var lampA:FlxSprite;
    public var lampB:FlxSprite;
    public var lampC:FlxSprite;
    public var lampD:FlxSprite;
    public var lampE:FlxSprite;
    public var lampF:FlxSprite;
    public var lamps:Array<FlxSprite>;
    public var imgText:FlxSprite;

    public var cameraFollowPointer:FlxObject;

    public var frame:FlxSprite;
    public var inside:FlxSprite;
    public var iconzone:FlxSprite;
    public var chineseKnot:FlxSprite;
    
    public var ribbon:FlxSprite;

    public var paolaToken:ColleMember;
    public var ropryToken:ColleMember;
    public var nicoToken:ColleMember;
    public var heidiToken:ColleMember;
    public var whitecatToken:ColleMember;
    public var rincyToken:ColleMember;
    public var isToken:ColleMember;
    public var sproutToken:ColleMember;
    public var pinkghostToken:ColleMember;
    public var unknownToken1:ColleMember;
    public var unknownToken2:ColleMember;
    public var unknownToken3:ColleMember;

    public var colles:Array<ColleMember>;

    public var tipText:FlxText;

    public var colleCamera:FlxCamera;
    public var mainCamera:FlxCamera;
    public var infoCamera:FlxCamera;
    public var otherCamera:FlxCamera;

    public var tokenL:FlxSprite;
    public var tokenLMesh:FlxSprite;


    override function create()
    {
        FlxG.mouse.visible=true;
        FlxG.mouse.load(Paths.image('UI/Mouse0',"mid-autumn"));

        colleCamera = new FlxCamera(35,70,940,530);
        mainCamera=new FlxCamera();
        infoCamera= new FlxCamera();
        otherCamera= new FlxCamera();

        colleCamera.bgColor.alpha = 0;
        infoCamera.bgColor.alpha = 0;
        otherCamera.bgColor.alpha=0;

        colleCamera.setScrollBoundsRect(0,0,940,670);

        FlxG.cameras.reset(mainCamera);
		FlxG.cameras.add(colleCamera, false);
        FlxG.cameras.add(otherCamera,false);
        FlxG.cameras.add(infoCamera,false);

        FlxG.cameras.setDefaultDrawTarget(mainCamera, true);

        CustomFadeTransition.nextCamera = otherCamera;

        FlxG.plugins.add(new FlxMouseEventManager());
    
        bg=new FlxSprite().loadGraphic(Paths.image('collectionstate/BG',"mid-autumn"));       
        bgLight = new FlxSprite().loadGraphic(Paths.image('collectionstate/BGLight',"mid-autumn"));
        guardrail=new FlxSprite().loadGraphic(Paths.image('collectionstate/Guardrail',"mid-autumn"));
        imgText=new FlxSprite().loadGraphic(Paths.image('collectionstate/Text','mid-autumn'));
        textBar=new FlxSprite(0,645).makeGraphic(1280,75,0x852F1948);

        ribbon=new FlxSprite().loadGraphic(Paths.image('collectionstate/Ribbon',"mid-autumn"));

        frame=new FlxSprite().loadGraphic(Paths.image('collectionstate/frameout','mid-autumn'));
        inside=new FlxSprite().loadGraphic(Paths.image('collectionstate/framein',"mid-autumn"));
        iconzone=new FlxSprite().loadGraphic(Paths.image('collectionstate/iconzone',"mid-autumn"));
        chineseKnot=new FlxSprite().loadGraphic(Paths.image('collectionstate/barup',"mid-autumn"));

        lampB = new FlxSprite(40,250).loadGraphic(Paths.image('collectionstate/Lamp',"mid-autumn"));
        lampC = new FlxSprite(245,360).loadGraphic(Paths.image('collectionstate/Lamp',"mid-autumn"));
        lampD = new FlxSprite(425,230).loadGraphic(Paths.image('collectionstate/Lamp',"mid-autumn"));
        lampE = new FlxSprite(845,225).loadGraphic(Paths.image('collectionstate/Lamp',"mid-autumn"));
        lampF = new FlxSprite(1015,285).loadGraphic(Paths.image('collectionstate/Lamp',"mid-autumn"));
        lampA = new FlxSprite(1210,235).loadGraphic(Paths.image('collectionstate/Lamp',"mid-autumn"));

        lamps=[lampA, lampB, lampC,lampD,lampE,lampF];

        paolaToken = new ColleMember(35,20,"Paola","在主界面输入正确字谜谜底（任意谜题）","Paola制作的小铃铛挂饰!和她尾巴上的那串是一对的哦!这是友谊的证明～",true,1,1);
        ropryToken = new ColleMember(265,20,"Ropry","唯一的一个特殊箭头sick接住并通过歌曲。","应该是手工制作的！用了一个很漂亮的盒子作为包装，似乎隆重了许多.",true,1,2);
        nicoToken = new ColleMember(495,20,"Nico","FullCombo","妮可亲手做的花包，挂着的纸条上写着 「中秋快乐」",true,1,3);
        heidiToken = new ColleMember(725,20,"Heidi","荷花灯特殊箭头一个不漏的接住。","蒂蒂用河边捡的莲子做成的手串，有这莲子的淡淡清香……",true,1,4);
        whitecatToken = new ColleMember(35,240,"Whitecat","收集酿酒材料并通过歌曲。","尘封多年的桂花酒，香气醇厚，从脏脏的陶瓷罐倒进了特制玻璃瓶。",true,2,1);
        rincyToken = new ColleMember(265,240,"Rincy","准确率百分之90以上并通过歌曲。","一个捧着圆月的幽灵Rincy钥匙扣。据称是本人自己画来特意定做的。摸起来总是凉凉的。",true,2,2);
        isToken = new ColleMember(495,240,"Is","很乖乖的一次都没按指定箭头，另外两种全按了并通过歌曲。","据说是某人想要出千而制作的，不过本人以做起来太累而放弃了这个想法。",true,2,3);
        sproutToken = new ColleMember(725,240,"Sprout","没有按到所有躲避箭头并通过歌曲。","芽芽亲手画的画，表现了他对你实力的认可。要好好保管！",true,2,4);
        pinkghostToken = new ColleMember(35,460,"Pinkghost","猜对一次问号箭头并通过歌曲。","赠予三次博饼里就中了一个一秀的老倒霉蛋。",true,3,1);
        unknownToken1= new ColleMember(265,460,"Unknown","敬请期待！","敬请期待！",false,3,2);
        unknownToken2= new ColleMember(495,460,"Unknown","敬请期待！","敬请期待！",false,3,3);
        unknownToken3= new ColleMember(725,460,"Unknown","敬请期待！","敬请期待！",false,3,4);

        tokenL=new FlxSprite();
        tokenL.alpha=0;
        tokenLMesh=new FlxSprite().makeGraphic(1280,720,0x80000000);
        tokenLMesh.alpha=0;

        ribbon.setGraphicSize(1280,720);
        ribbon.updateHitbox();
        
        colles=[paolaToken,ropryToken,nicoToken,heidiToken,whitecatToken,rincyToken,isToken,sproutToken,pinkghostToken,unknownToken1,unknownToken2,unknownToken3];

        cameraFollowPointer= new FlxObject(0, 0, 350, 300);

        tokenL.cameras=[infoCamera];
        tokenLMesh.cameras=[infoCamera];

        LoadTokenLock();

        for(collection in colles)
        {
            collection.cameras=[colleCamera];
            if(collection.unlocked&&collection.canUnlock)
                collection.animation.play("Normal");
            else
                collection.animation.play("Locked"); 
        }

        cameraFollowPointer.cameras=[colleCamera];

        chineseKnot.cameras=[otherCamera];

        tipText = new FlxText(160,650,1220-160,"测试用字体,目前没有任何String导入",24);
        tipText.setFormat("assets/fonts/ZhengDaoCuShuTi.ttf",tipText.size);
        tipText.color=0xFFFFFFFF;

        memberX=1;
        memberY=1;
        LoadTokenInfo(memberX,memberY);
        textCache="可以用鼠标操作哦！";

        if(mouseControl)
        {
            keyboardControl=false;
            LoadTokenInfo(memberX,memberY);
        }

        add(bg);
        for(lamp in lamps)
        {
            add(lamp);
        }
        add(guardrail);
        add(ribbon);
        add(frame);
        add(inside);
        add(textBar);
        add(iconzone);
        add(chineseKnot);

        for(collection in colles)
        {
        add(collection);
        }
        add(bgLight);
        add(imgText);

        add(tipText);

        add(tokenLMesh);
        add(tokenL);

        super.create();
    }

    override function update(elapsed:Float)
    {
     
        tipText.text=textCache;

        if(!tokenLargeState)   
        TokenSUpdate();
        else if(tokenLargeState)
        TokenLUpdate();

        FlxG.watch.addQuick('memberX',memberX);
        FlxG.watch.addQuick('memberY',memberY);
        FlxG.watch.addQuick('cameraFollowPointer',cameraFollowPointer.y);
        FlxG.watch.addQuick('FlxG.mouse.wheel',FlxG.mouse.wheel);
        FlxG.watch.addQuick('keyboardControl',keyboardControl);
        FlxG.watch.addQuick('mouseControl',mouseControl);
        FlxG.watch.addQuick('isTransing',isTransing);
        FlxG.watch.addQuick("tokenLargeState",tokenLargeState);
        FlxG.watch.addQuick("COLLECTIONS_UNLOCK",SaveData.COLLECTIONS_UNLOCK);
        super.update(elapsed);
    }

    function TokenSUpdate()
    {
            if(FlxG.mouse.wheel>0&&cameraFollowPointer.y>=0)
            {
                if(keyboardControl)
                    keyboardControl=false;
                cameraFollowPointer.y-=70;
                colleCamera.follow(cameraFollowPointer);
            }
            else if(cameraFollowPointer.y<0)
            {
                cameraFollowPointer.y=0;
            }
            if(FlxG.mouse.wheel<0&&cameraFollowPointer.y<=180)
            {
                if(keyboardControl)
                    keyboardControl=false;
                cameraFollowPointer.y+=70;
                colleCamera.follow(cameraFollowPointer);
            }
            else if(cameraFollowPointer.y>180)
            {
                cameraFollowPointer.y=180;
            }
            if(FlxG.keys.justPressed.ONE)
            {
                DebugAllTrue();
            }
            if(FlxG.keys.justPressed.TWO)
            {
                DebugAllFalse();
            }
            if(controls.ACCEPT&&targetToken.unlocked)
            {
                mouseClicked=true;
            }
            if(mouseClicked&&!isTransing&&!(memberX==3&&memberY>1))
                {
                    MouseEventDisable();
                    isTransing=true;
                    tokenL.loadGraphic(Paths.image('collectionstate/TokenL/'+tokenLargeName+"TokenL",'mid-autumn'));
                    LoadTokenInfo(memberX,memberY);
                    FlxTween.tween(tokenLMesh,{alpha:1},0.5);
                    FlxTween.tween(tokenL,{alpha:1},0.5,{onComplete: function(twn:FlxTween){
                        isTransing=false;
                        tokenLargeState=true;
                        mouseClicked=false;
                    }});
                }

            if(!mouseControl)
            {
                if(controls.UI_DOWN_P&&memberX<=3)
                    {
                        keyboardControl=true;
                        memberX++;
                        LoadTokenInfo(memberX,memberY);
                    }
                else if(memberX>3)
                    {
                            memberX=3;
                            LoadTokenInfo(memberX,memberY);
                    }
                if(controls.UI_UP_P&&memberX>=1)
                    {
                            keyboardControl=true;
                            memberX--;
                            LoadTokenInfo(memberX,memberY);
                    }
                else if(memberX<1)
                    {
                            memberX=1;
                            LoadTokenInfo(memberX,memberY);
                    }
                if(controls.UI_LEFT_P&&memberY>=1)
                    {
                            keyboardControl=true;
                            memberY--;
                            LoadTokenInfo(memberX,memberY);
                    }
                else if(memberY<1)
                    {
                            memberY=1;
                            LoadTokenInfo(memberX,memberY);
                    }
                if(controls.UI_RIGHT_P&&memberY<=4)
                    {
                            keyboardControl=true;
                            memberY++;
                            LoadTokenInfo(memberX,memberY);
                    }
                else if(memberY>4)
                    {
                            memberY=4;
                            LoadTokenInfo(memberX,memberY);
                    }
                if(keyboardControl)
                    {
                        if(memberX==1&&cameraFollowPointer.y>0)
                            {
                            cameraFollowPointer.y=0;
                            colleCamera.follow(cameraFollowPointer);
                            }
                        if(memberX==3&&cameraFollowPointer.y<180)
                            {    
                                colleCamera.follow(cameraFollowPointer);
                                cameraFollowPointer.y=180;
                            }
                    }
            }

            if(keyboardControl&&mouseControl)
            {
                LoadTokenInfo(memberX,memberY);
                keyboardControl=false;
            }
            if(FlxG.mouse.justPressedRight||controls.BACK)
            {

                tokenLargeName="Paola";
                // targetToken=paolaToken;
                CustomFadeTransition.nextCamera = otherCamera;
                SaveData.SaveCollectionUnlock();
                MusicBeatState.switchState(new MainMenuState());
            }

    }
    function TokenLUpdate()
    {
        if(controls.BACK&&!isTransing)
        {
            
            isTransing=true;
            FlxTween.tween(tokenLMesh,{alpha:0},0.5);
            FlxTween.tween(tokenL,{alpha:0},0.5,{onComplete: function(twn:FlxTween){
                isTransing=false;
                tokenLargeState=false;
                MouseEventEnable();
            }});
        }
        if(FlxG.mouse.justPressedRight&&!isTransing)
        {
            isTransing=true;
            FlxTween.tween(tokenLMesh,{alpha:0},0.5);
            FlxTween.tween(tokenL,{alpha:0},0.5,{onComplete: function(twn:FlxTween){
                isTransing=false;
                tokenLargeState=false;
                MouseEventEnable();
            }});
        }
    }
    function LoadTokenInfo(X:Int,Y:Int)
    {
            ClearTokenSelect();
            for(collection in colles)
            {
             if(collection.positionX==X)
                {
                if(collection.positionY==Y)
                    {
                        targetToken=collection;
                        if(collection.unlocked&&collection.canUnlock)
                            {
                                collection.selected=true;
                                tokenLargeName=collection.name;
                                collection.animation.play("NormalSelected");
                                textCache=collection.unlockedText;
                            }
                             else if(!collection.unlocked)
                            {
                                collection.selected=true;
                                collection.animation.play("LockSelected");
                                textCache=collection.lockedText;
                            }
                    }
                    else
                    continue;
                }
                else
                continue;
            }
            
    }

    public function ClearTokenSelect()
    {
        for(collection in colles)
            {
            if(collection.unlocked&&collection.canUnlock)
                {
                    collection.selected=false;
                    collection.animation.play("Normal");
                }
                else if(!collection.canUnlock||(collection.canUnlock&&!collection.unlocked))
                {
                    collection.selected=false;
                    collection.animation.play("Locked");
                }
            }
    }

    public function MouseEventDisable()
    {
        for(collection in colles)
            {
                collection.stopEvnet();
            }
    }

    public function MouseEventEnable()
        {
            for(collection in colles)
                {
                    collection.startEvnet();
                }
        }

    public function LoadTokenLock()
    {
        if(!SaveData.PROJECT_IS_FINISH)
        {
            for(i in 0...8)
            {
                // colles[i].unlocked=SaveData.COLLECTIONS_UNLOCK[i];
            }
        }
        else
        {
            for(collection in colles)
            {
                collection.unlocked=SaveData.COLLECTIONS_UNLOCK[collection.ID];
            }
        }
    }

    public function DebugAllTrue()
    {
        for(collection in colles)
            {
                if(collection.canUnlock)
                collection.unlocked=true;
            }
    }
    public function DebugAllFalse()
    {
        for(collection in colles)
            {
                if(collection.canUnlock)
                collection.unlocked=false;
            }
    }
}