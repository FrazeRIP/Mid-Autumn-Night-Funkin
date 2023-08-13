package ;

#if VIDEOS_ALLOWED
import vlc.MP4Handler;
#end

import flixel.FlxSprite;
import FunkinLua.ModchartSprite;

/**
 * This class will play the video in the form of a FlxSprite, which you can control.
 */
class MP4ModSprite extends ModchartSprite
{
	public var readyCallback:Void->Void;
	public var finishCallback:Void->Void;

	public var video:MP4Handler;
	
	public var videoName:String;

	public function new(filename:String, x:Float = 0, y:Float = 0, width:Float = 1280, height:Float = 720, autoScale:Bool = true)
	{
		super(x, y);

		videoName = filename;

		video = new MP4Handler(width, height, autoScale);
		video.alpha = 0;

		video.readyCallback = function()
		{
			loadGraphic(video.bitmapData);
			pause();
			
			if (readyCallback != null)
				readyCallback();
		}

		video.finishCallback = function()
		{
			if (finishCallback != null)
				finishCallback();

			kill();
		};

		setupVideoAuto(filename);
	}

	
	/**
	 * Native video support for Flixel & OpenFL
	 * @param path Example: `your/video/here.mp4`
	 * @param repeat Repeat the video.
	 * @param pauseMusic Pause music until done video.
	 */
	public function playVideo(path:String, ?repeat:Bool = false, pauseMusic:Bool = false)
	{
		video.playVideo(path, repeat, pauseMusic);
	}

	public function playVideoAuto(filename:String, ?repeat:Bool = false, pauseMusic:Bool = false)
		{
			var filepath:String = Paths.video(filename);
			video.playVideo(filepath, repeat, pauseMusic);
		}
	
	
	public function setupVideoAuto(filename:String, ?repeat:Bool = false, pauseMusic:Bool = false)
		{
			var filepath:String = Paths.video(filename);
			trace("Loading Video From " +filepath);
			video.playVideo(filepath, repeat, pauseMusic);
			pause();
			trace("Video loaded successfully");
		}

	public function pause()
	{
		video.pause();
	}

	public function resume()
	{
		video.resume();
	}
}
