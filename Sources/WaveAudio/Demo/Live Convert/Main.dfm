�
 TMAINFORM 0k  TPF0	TMainFormMainFormLeft� Top� BorderStylebsDialogCaptionWave Format ConversionClientHeight� ClientWidth� Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style OldCreateOrder	OnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TLabelLabel1LeftTopWidthzHeightCaptionRecord/Playback Format:FocusControlcbFormat  TLabelLabel2LeftTop8WidthYHeightCaptionOutput File Format:FocusControlebFileFormat  TButton	btnRecordLeftTop� WidthKHeightCaptionRecordTabOrderOnClickbtnRecordClick  TProgressBarProgressBarLeftToppWidth� HeightMin MaxdTabOrder  TButtonbtnStopLeftWTop� WidthKHeightCaptionStopTabOrderOnClickbtnStopClick  TButtonbtnPlayLeft� Top� WidthKHeightCaptionPlayTabOrderOnClickbtnPlayClick  	TComboBoxcbFormatLeftTopWidth� HeightStylecsDropDownList
ItemHeightTabOrder OnChangecbFormatChange  TEditebFileFormatLeftTopHWidth� HeightReadOnly	TabOrder  TButtonbtnTargetFormatLeft� TopHWidth;HeightCaption	Change...TabOrderOnClickbtnTargetFormatClick  TLiveAudioRecorderLiveRecorder	PCMFormatMono16bit22050HzBufferLengthdBufferCount

OnActivateLiveRecorderActivateOnDeactivateLiveRecorderDeactivateOnLevelLiveRecorderLevelOnDataLiveRecorderDataLeft� Top	  TWaveStorageTargetFormatLefthTop9Data
<   RIFF4   WAVEfmt    1  "V  ~  A    @fact       data      TLiveAudioPlayer
LivePlayer	PCMFormatMono16bit22050HzBufferLengthdBufferCount

OnActivateLivePlayerActivateOnDeactivateLivePlayerDeactivateOnLevelLivePlayerLevelOnDataLivePlayerDataLeft� Top	  TOpenDialog
OpenDialog
DefaultExtwavFilterWave Files|*.wav;*.waveTitleSelect Template WaveLeft� Top8   