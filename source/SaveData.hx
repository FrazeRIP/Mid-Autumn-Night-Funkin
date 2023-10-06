package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.system.FlxSound;

enum LevelName
{
    
}
class SaveData
{
    public static var levelName:Map<String,Int>=new Map<String,Int>();

    public static var PROJECT_IS_FINISH:Bool=true;//unknown完成后直接把这里改成true
    //关卡、角色及其对应在array数组中位置
    //        
    //关卡名：华灯初上  金樽之礼  花前月下  清溪吟月  酌酒风清  祭月坛眀 如远行客 意在笔先 棋韵叮当   未知1     未知2    未知3
    //角色名： paola    ropry     nico     heidi   whitecat  rincy     is    sprout  pinkghost unknown1 unknown2 unknown3
    //数组号：  0         1        2         3        4        5       6       7        8         9        10      11
    public static var STORYMODE_PUZZLE_SAVE:Array<Int>=
    [0,0,0,0,0,0,0,0,0,0,0,0];//字谜
    public static var STORY_UNLOCK_SAVE:Array<Int>=
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0];//关卡
    //0=未解锁 1=已解锁
    public static var HIGH_SCORE:Array<Int>=
    [0,0,0,0,0,0,0,0,0,0,0,0,0,0];//最高分【看情况要不要，不要直接删了也行
    public static var COLLECTIONS_UNLOCK:Array<Int>=
    [0,0,0,0,0,0,0,0,0,0,0,0];//信物解锁情况
    public static var COLLECTIONS_SPECIAL:Bool=false;//特殊信物解锁情况

    public static function InitLevelName()
        {
            levelName = ["tutorial"=>0,'hua_deng_chu_shang'=>1,'jin_zun_zhi_li'=>2,'hua_qian_yue_xia'=>3,'qing_xi_yin_yue'=>4,'zhuo_jiu_feng_qing'=>5,'hua_hao_yue_yuan'=>6,'ji_yue_tan_ming'=>7,'xin_qi_chao_ting'=>8,'zhan_yan_zhou_tong'=>9,'ru_yuan_xing_ke'=>10,'yi_zai_bi_xian'=>11,'qi_yun_ding_dang'=>12,"ending"=>13];
        }
    /**
	 * Storys State Update
	 *
	 * @param	storyName			Level name
	 * @param	state				0:Locked, 1:Unlocked ,2:Finished
	 */
    public static function StoryStateUpdate(storyName:String,state:Int) {
        STORY_UNLOCK_SAVE[levelName[storyName]]=state;
        SaveStory();
    }
    /**
	 * Storys Puzzle State Update
	 *
	 * @param	storyName			Level name
	 * @param	state				0:Locked, 1:Unlocked ,2:Finished
	 */
    public static function StoryPuzzleStateUpdate(storyName:String,state:Int){
        STORYMODE_PUZZLE_SAVE[levelName[storyName]]=state;
        SavePuzzle();
    }
    public static function CollectionsUnlocked(storyName:String){
        COLLECTIONS_UNLOCK[levelName[storyName]]=1;
        SaveCollectionUnlock();
    }
    public static function SpecialCollectionUnlocked()
    {
        COLLECTIONS_SPECIAL=true;
        SaveCollectionUnlock();
    }
    public static function SavePuzzle() {
        FlxG.save.data.puzzleSave=STORYMODE_PUZZLE_SAVE;
    }
    
    public static function SaveStory() {
        FlxG.save.data.storySave=STORY_UNLOCK_SAVE;
    }

    public static function SaveCollectionUnlock() {
        FlxG.save.data.collectionUnlock=COLLECTIONS_UNLOCK;
        FlxG.save.data.collectionSpecial=COLLECTIONS_SPECIAL;
    }

    public static function SaveHighScore(){
        FlxG.save.data.HighScore=HIGH_SCORE;
    }

    public static function SaveAll(){
        SavePuzzle();
        SaveStory();
        SaveCollectionUnlock();
        SaveHighScore();
    }
    public static function LoadUnLock() {
        if(FlxG.save.data.storySave!=null)
        {
            STORY_UNLOCK_SAVE=FlxG.save.data.storySave;
        }
        else
        {
            FlxG.save.data.storySave=STORY_UNLOCK_SAVE;
        }
    }
    public static function LoadAll(){
        if(FlxG.save.data.puzzleSave!=null)
        STORYMODE_PUZZLE_SAVE = FlxG.save.data.puzzleSave;
        else
        {
            STORYMODE_PUZZLE_SAVE=[0,0,0,0,0,0,0,0,0,0,0,0];
            FlxG.save.data.puzzleSave=STORYMODE_PUZZLE_SAVE;
        }

        if(FlxG.save.data.storySave!=null)
        STORY_UNLOCK_SAVE=FlxG.save.data.storySave;
        else
        {
            STORY_UNLOCK_SAVE=[1,0,0,0,0,0,0,0,0,0,0,0,0,0];
            FlxG.save.data.storySave=STORY_UNLOCK_SAVE;
        }
        
        if(FlxG.save.data.collectionUnlock!=null)
        COLLECTIONS_UNLOCK=FlxG.save.data.collectionUnlock;
        else
        {
            COLLECTIONS_UNLOCK=[0,0,0,0,0,0,0,0,0,0,0,0];
            FlxG.save.data.collectionUnlock=COLLECTIONS_UNLOCK;
        }

        if(FlxG.save.data.HighScore!=null)
            HIGH_SCORE=FlxG.save.data.HighScore;
        else
        {
            HIGH_SCORE= [0,0,0,0,0,0,0,0,0,0,0,0,0,0];
            FlxG.save.data.HighScore=HIGH_SCORE;
        }
        if(FlxG.save.data.collectionSpecial!=null)
        COLLECTIONS_SPECIAL=FlxG.save.data.collectionSpecial;
        else
        {
            COLLECTIONS_SPECIAL=false;
            FlxG.save.data.collectionSpecial=COLLECTIONS_SPECIAL;
        }
    }
}