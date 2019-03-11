package examples.media
{
	import org.osmf.display.MediaPlayerSprite;
	import org.osmf.display.ScaleMode;
	import org.osmf.events.AudioEvent;
	import org.osmf.events.BufferEvent;
	import org.osmf.events.DisplayObjectEvent;
	import org.osmf.events.DynamicStreamEvent;
	import org.osmf.events.LoadEvent;
	import org.osmf.events.MediaErrorEvent;
	import org.osmf.events.MediaPlayerCapabilityChangeEvent;
	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.events.PlayEvent;
	import org.osmf.events.TimeEvent;
	import org.osmf.media.DefaultMediaFactory;
	import org.osmf.media.URLResource;
	import org.osmf.utils.URL;

	import flash.events.Event;
	/**
	 * @author ssen (i@ssen.name)
	 */
	public class MediaPlayerExample extends MediaPlayerSprite 
	{
		private var _factory : DefaultMediaFactory;
		private var _scaled : Boolean;

		
		public function MediaPlayerExample()
		{
			opaqueBackground = 0x000000;
			scaleMode = ScaleMode.LETTERBOX;
			_factory = new DefaultMediaFactory();
			load("medias/example.mp4");
		}
		public function load(url : String) : void
		{
			/*
			 * play, pause, playbackerror, buffering 등의 스테이트 변화 
			 */
			// 중요 : loading, playing, playbackerror, buffering 가장 핵심적인 이벤트 
			mediaPlayer.addEventListener(MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE, mediaPlayerStateChange);
			// 중요 : 플레이 상태 여부, 버퍼링 여부를 체크하지 않는다.
			mediaPlayer.addEventListener(PlayEvent.PLAY_STATE_CHANGE, playStateChange);
			/*
			 * 각 종 상태 체크
			 */
			// 오디오 사용 가능 여부 
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.HAS_AUDIO_CHANGE, hasAudioChange);
			// 버터 사용 가능 여부 
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_BUFFER_CHANGE, canBufferChange);
			// ?
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.TEMPORAL_CHANGE, temporalChange);
			// 플레이가 가능한지 체크
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_PLAY_CHANGE, canPlayChange);
			/*
			 * 
			 */
			// 중요 : 음소거 변화 
			mediaPlayer.addEventListener(AudioEvent.MUTED_CHANGE, event);
			mediaPlayer.addEventListener(AudioEvent.PAN_CHANGE, event);
			// 중요 : 음량 변화 
			mediaPlayer.addEventListener(AudioEvent.VOLUME_CHANGE, event);
			// 버퍼 타임 변화 
			mediaPlayer.addEventListener(BufferEvent.BUFFER_TIME_CHANGE, event);
			// 버퍼링 변화 
			mediaPlayer.addEventListener(BufferEvent.BUFFERING_CHANGE, event);
			mediaPlayer.addEventListener(DisplayObjectEvent.DISPLAY_OBJECT_CHANGE, event);
			// 중요 : 미디어의 사이즈 변화 
			mediaPlayer.addEventListener(DisplayObjectEvent.MEDIA_SIZE_CHANGE, event);
			mediaPlayer.addEventListener(DynamicStreamEvent.AUTO_SWITCH_CHANGE, event);
			mediaPlayer.addEventListener(DynamicStreamEvent.NUM_DYNAMIC_STREAMS_CHANGE, event);
			mediaPlayer.addEventListener(DynamicStreamEvent.SWITCHING_CHANGE, event);
			mediaPlayer.addEventListener(LoadEvent.BYTES_LOADED_CHANGE, event);
			mediaPlayer.addEventListener(LoadEvent.BYTES_TOTAL_CHANGE, event);
			mediaPlayer.addEventListener(MediaErrorEvent.MEDIA_ERROR, event);
			
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_LOAD_CHANGE, event);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_PAUSE_CHANGE, event);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.CAN_SEEK_CHANGE, event);
			mediaPlayer.addEventListener(MediaPlayerCapabilityChangeEvent.IS_DYNAMIC_STREAM_CHANGE, event);
			// 중요 : 타임라인 끝 
			mediaPlayer.addEventListener(TimeEvent.COMPLETE, event);
			// 중요 : 타임라인 변화 
			mediaPlayer.addEventListener(TimeEvent.CURRENT_TIME_CHANGE, event);
			mediaPlayer.addEventListener(TimeEvent.DURATION_CHANGE, event);
			
			mediaElement = _factory.createMediaElement(new URLResource(new URL(url)));
			mediaPlayer.media = mediaElement;
		}
		private function playStateChange(event : PlayEvent) : void 
		{
			trace(mediaPlayer.state, event);
		}
		private function temporalChange(event : MediaPlayerCapabilityChangeEvent) : void 
		{
			trace(mediaPlayer.temporal, event);
		}
		private function canBufferChange(event : MediaPlayerCapabilityChangeEvent) : void 
		{
			trace(mediaPlayer.canBuffer, event);
		}
		private function hasAudioChange(event : MediaPlayerCapabilityChangeEvent) : void 
		{
			trace(mediaPlayer.hasAudio, event);
		}
		private function canPlayChange(event : MediaPlayerCapabilityChangeEvent) : void 
		{
			trace(mediaPlayer.canPlay, event);
		}
		private function mediaPlayerStateChange(event : MediaPlayerStateChangeEvent) : void 
		{
			trace(mediaPlayer.bytesLoaded, mediaPlayer.bytesTotal, mediaPlayer.state, mediaPlayer.mediaWidth, mediaPlayer.mediaHeight, event);
			if (!_scaled && mediaPlayer.mediaWidth > 0) {
				width = 550;
				height = 400;
				_scaled = true;
			}
		}
		private function event(event : Event) : void 
		{
			trace(event);
		}
	}
}
